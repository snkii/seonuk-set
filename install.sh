#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DEST_DIR="$(dirname "$SCRIPT_DIR")"

FILES=(".zshrc" ".bash_profile" ".bashrc" ".tmux.conf" ".vimrc" "seonuk-set.sh")

echo "setting 복사 시작"

for filename in "${FILES[@]}"; do
    SRC="$SCRIPT_DIR/$filename"
    DEST="$DEST_DIR/$filename"

    if [ -f "$SRC" ]; then
        if [ -f "$DEST" ]; then
            cp -v "$DEST" "$DEST.bak"
            echo "기존 $filename → $filename.bak 로 백업"
        fi

        cp -v "$SRC" "$DEST"
    else
        echo "$filename 없음"
    fi
done

echo "setting 복사 및 기존 setting 백업이 완료"

