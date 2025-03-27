#!/bin/bash

# 백업 디렉토리 이름
BACKUP_DIR="seonuk_set"

# 백업 디렉토리가 없으면 생성
mkdir -p "$BACKUP_DIR"

# 복사할 파일 리스트
FILES=(".bashrc" ".bash_profile" ".vimrc" ".tmux.conf")

# 각 파일을 확인하고 존재할 경우 복사
for file in "${FILES[@]}"; do
    if [ -f ~/"$file" ]; then
        cp ~/"$file" "$BACKUP_DIR/"
        echo "$file 백업 완료"
    else
        echo "$file 없음, 건너뜀"
    fi
done

