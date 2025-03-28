#!/bin/bash

# 현재 스크립트가 위치한 디렉토리 (seonuk_set)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 복사 대상 디렉토리 (seonuk_set의 상위 디렉토리)
DEST_DIR="$(dirname "$SCRIPT_DIR")"

# 복사할 파일 목록
FILES=(".bash_profile" ".bashrc" ".tmux.conf" ".vimrc" "seonuk-set.sh")

echo "🔧 설정 파일 설치 시작..."

for filename in "${FILES[@]}"; do
    SRC="$SCRIPT_DIR/$filename"
    DEST="$DEST_DIR/$filename"

    if [ -f "$SRC" ]; then
        # 기존 파일이 있으면 .bak으로 백업
        if [ -f "$DEST" ]; then
            cp -v "$DEST" "$DEST.bak"
            echo "🗂️  기존 $filename → $filename.bak 로 백업함"
        fi

        # 새 파일 복사
        cp -v "$SRC" "$DEST"
    else
        echo "⚠️  $filename 파일이 존재하지 않아 건너뜀"
    fi
done

echo "✅ 설치 완료: 파일 복사 및 백업이 완료되었습니다."

