#!/usr/bin/env bash
set -euo pipefail

if ((EUID != 0)); then
	echo >&2 "permission denied"
	exit 1
fi

USER="${SUDO_USER:-$(whoami)}"
GROUP="users"
INITIAL_NIXOS_CONFIG_DIR=/etc/nixos
NEW_NIXOS_CONFIG_DIR="$(getent passwd "$USER" | cut -d: -f6)/nixos_configuration/nixos"
GIT_DIRECTORY="$(dirname "$NEW_NIXOS_CONFIG_DIR")"

spushd() { pushd "$1" >/dev/null; }
spopd() { popd >/dev/null; }

init_link() {
	mkdir -p "$NEW_NIXOS_CONFIG_DIR"
	cp -a "$INITIAL_NIXOS_CONFIG_DIR/." "$NEW_NIXOS_CONFIG_DIR"
	chown -R "$USER":"$GROUP" "$NEW_NIXOS_CONFIG_DIR"
	if [ -e "$INITIAL_NIXOS_CONFIG_DIR.bak" ]; then
		mv -T "$INITIAL_NIXOS_CONFIG_DIR.bak" "$INITIAL_NIXOS_CONFIG_DIR.$(date +%s).bak"
	else
		mv -T "$INITIAL_NIXOS_CONFIG_DIR" "$INITIAL_NIXOS_CONFIG_DIR.bak"
	fi
	ln -s "$NEW_NIXOS_CONFIG_DIR" "$INITIAL_NIXOS_CONFIG_DIR"
}

is_link_initialized() {
	[ -L "$INITIAL_NIXOS_CONFIG_DIR" ] &&
		[ "$(readlink -f "$INITIAL_NIXOS_CONFIG_DIR")" = "$(readlink -f "$NEW_NIXOS_CONFIG_DIR")" ]
}

if ! is_link_initialized; then
	echo "not initialized: initializing..."
	init_link
	echo "initialized: $INITIAL_NIXOS_CONFIG_DIR -> $NEW_NIXOS_CONFIG_DIR"
fi

push_changes() {
	sudo -u "$USER" git push -u origin main ||
		(echo "git push failed!" && exit 1)
	echo "PUSH SUCCESSFUL!"
}

init_git_repo() {
	spushd "$GIT_DIRECTORY"
	sudo -u "$USER" git init
	sudo -u "$USER" git add -A
	sudo -u "$USER" git commit --allow-empty -m "initial commit"
	sudo -u "$USER" git branch -M main
	sudo -u "$USER" git remote add origin "$1"
	push_changes
	spopd
}

is_git_repo_initialized() {
	if [ -d "$GIT_DIRECTORY/.git" ]; then
		# Check if a remote named "origin" exists
		if git -C "$GIT_DIRECTORY" remote get-url origin >/dev/null 2>&1; then
			return 0
		fi
	fi
	return 1
}

if ! is_git_repo_initialized; then
	echo "no git repo or remote found: initializing..."
	printf "%s" "Enter remote: "
	read -r remote
	init_git_repo "$remote"
	echo "initialized: remote -> $remote"
fi

alejandra "$NEW_NIXOS_CONFIG_DIR" &>/dev/null ||
	(
		alejandra "$NEW_NIXOS_CONFIG_DIR"
		echo "formatting failed!" && exit 1
	)

spushd "$GIT_DIRECTORY"

# Shows your changes
git diff -U0 -- '*.nix'

log_file=$(mktemp)

trap 'spopd; echo "wrote logs to $log_file"' EXIT

echo "rebuilding..."

if nixos-rebuild switch &>"$log_file"; then
	echo "BUILD SUCCESSFUL!"
else
	grep --color error "$log_file"
	echo "BUILD FAILED!"
	exit 1
fi

current=$(nixos-rebuild list-generations | grep current)
sudo -u "$USER" git add -A
if git diff --cached --quiet -- '*.nix'; then
	echo 'no staged *.nix changes: skipping commit...'
else
	sudo -u "$USER" git commit -m "${current:-"nixos rebuild"}" || true
fi
push_changes
