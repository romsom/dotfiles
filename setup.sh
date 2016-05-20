#!/bin/bash
PWD=$(pwd)
DIRS=( emacs.d i3 )

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
      echo "$file"
     rm -f "$link_dir"/$(basename "$file")
     ln -s "$PWD"/"$file" "$link_dir"/$(basename "$file")
    fi
  done
done
