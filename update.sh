#!/usr/bin/env bash
# Update scripted inspired by noboilerplate

pushd /home/user/.dotfiles/

if git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    popd
    exit 0
fi

alejandra . &>/dev/null \
  || ( alejandra . ; echo "formatting failed!" && exit 1)

git diff -U0 '*.nix'

echo "NixOS Rebuilding..."

git add .

# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch  --flake /home/user/.dotfiles &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

# Commit all changes witih the generation metadata
git commit

# Back to where you were
popd
