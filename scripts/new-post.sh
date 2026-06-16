#!/bin/bash
# 快速创建新文章（每个文章独立目录）
# 用法:
#   ./scripts/new-post.sh "如何组装一台服务器" "how-to-build-server"
#   ./scripts/new-post.sh "How to build a server"
#   ./scripts/new-post.sh "How to build a server" "custom-slug"

if [ -z "$1" ]; then
  echo "用法:"
  echo "  ./scripts/new-post.sh \"中文标题\" \"english-slug\""
  echo "  ./scripts/new-post.sh \"English title\""
  echo "  ./scripts/new-post.sh \"English title\" \"custom-slug\""
  exit 1
fi

TITLE="$1"
DATE=$(date +%Y-%m-%d)
HAS_CJK=$(python3 -c "
import sys; t=sys.argv[1]
cjk = any('\u4e00' <= c <= '\u9fff' or '\u3040' <= c <= '\u30ff' for c in t)
print(1 if cjk else 0)
" "$TITLE" 2>/dev/null || echo 0)

if [ -z "$2" ]; then
  if [ "$HAS_CJK" = "1" ]; then
    echo "❌ 中文标题需要提供英文目录名："
    echo "   ./scripts/new-post.sh \"$TITLE\" \"english-slug\""
    exit 1
  fi
  SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')
else
  SLUG=$(echo "$2" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')
fi

DIR="src/content/posts/${SLUG}"
mkdir -p "$DIR"

cat > "$DIR/index.md" << MDEOF
---
title: ${TITLE}
published: ${DATE}
description:
image:
tags: []
category:
draft: false
---

## 
MDEOF

echo "✅ 已创建: ${DIR}/"
echo "   ├── index.md"
echo "   └── 封面图放这里，image: ./cover.jpg"
