#!/usr/bin/env bash
# Update scripted inspired by noboilerplate

pushd /home/user/.dotfiles/


changes=$(git diff @{upstream} --color)
changes=$changes$(git ls-files --others --exclude-standard |
    while read -r i; do git diff @{upstream} --color -- /dev/null "$i" ; done)

if test -z $changes; then
    echo "No changes detected, exiting."
    popd
    exit 0
fi

git diff @{upstream} --color
git ls-files --others --exclude-standard |
    while read -r i; do git diff @{upstream} --color -- /dev/null "$i"; done

alejandra . &>/dev/null \
  || ( alejandra . ; echo "formatting failed!" && exit 1)

git add .

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch  --flake /home/user/.dotfiles &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

# Commit all changes
git commit

# Back to where you were
popd
