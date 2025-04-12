#!/bin/bash

BACKUP_DIR="seonuk-set"

mkdir -p "$BACKUP_DIR"

FILES=(".zshrc" ".bashrc" ".bash_profile" ".vimrc" ".tmux.conf")

for file in "${FILES[@]}"; do
    if [ -f ~/"$file" ]; then
        cp ~/"$file" "$BACKUP_DIR/"
        echo "$file 백업 완료"
    else
        echo "$file 파일 없음"
    fi
done

SCRIPT_PATH="$(readlink -f "$0")"
SCRIPT_NAME="$(basename "$SCRIPT_PATH")"
cp "$SCRIPT_PATH" "$BACKUP_DIR/"
echo "$SCRIPT_NAME 백업 완료"

