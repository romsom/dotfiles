#!/bin/bash
PWD=$(pwd)
DIRS=( emacs.d i3 xmonad offlineimap termite "systemd/user" )

# find config directories in home and replace config files with symlinks to repo
for dir in "${DIRS[@]}"; do
  if [[ -d "$HOME/.$dir" ]]; then
    link_dir="$HOME/.$dir"
#    echo "found $link_dir"
  elif [[ -d "$HOME/.config/$dir" ]]; then
    link_dir="$HOME/.config/$dir"
#    echo "found $link_dir"
  else
    echo "WARNING: config directory $dir was not found in your home, please check if that program is installed"
    continue
  fi
  echo "dir: $link_dir"
  for file in "$dir"/*; do
    if [[ -f "$file" ]]; then
      echo "$link_dir/$(basename "$file")"
     rm -f "$link_dir/$(basename "$file")"
     ln -s "$PWD"/"$file" "$link_dir/$(basename "$file")"
    fi
  done
done

echo "linking single config/rc files"
# dotfiles
DOTFILES=( zshrc.local xmobarrc xprofile offlineimaprc msmtprc flake8 )
for f in "${DOTFILES[@]}"; do
    # create link with '.' prefixed
    echo "$f --> $HOME/.$f"
    rm -f "$HOME/.$f"
    ln -s "$PWD/$f" "$HOME/.$f"
done

echo "linking single config/rc files inside ~/.config/"
# dotfiles
CONFIG_DOTFILES=( mimeapps.list )
for f in "${CONFIG_DOTFILES[@]}"; do
    # create link inside ~/.config/
    echo "$f --> $HOME/.config/$f"
    rm -f "$HOME/.config/$f"
    ln -s "$PWD/$f" "$HOME/.config/$f"
done
