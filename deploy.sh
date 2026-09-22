#!/usr/bin/env bash
# ぷ〜ん！かずあそび を GitHub Pages に 公開する。
#
#   Mac の ターミナルで 実行する（サンドボックスには GitHub の 認証が ないので ここでは できない）
#     cd /Users/afiri/Desktop/MulmoClaude/artifacts/deploy/puun-kazuasobi
#     ./deploy.sh                 … puun-kazuasobi という 名前で 公開
#     ./deploy.sh すきな名前        … 名前を 変えたい とき
#
#   はじめて つかう ときは さきに:  gh auth login
set -euo pipefail
cd "$(dirname "$0")"
REPO="${1:-puun-kazuasobi}"

if ! command -v gh >/dev/null 2>&1; then
  echo "gh（GitHub CLI）が 入って いません。  brew install gh  を さきに どうぞ。" >&2
  exit 1
fi
if ! gh auth status >/dev/null 2>&1; then
  echo "gh に ログインして いません。  gh auth login  を さきに どうぞ。" >&2
  exit 1
fi
USER="$(gh api user -q .login)"

git init -q 2>/dev/null || true
git add -A
git commit -qm "ぷ〜ん！かずあそび を 公開" 2>/dev/null || echo "（変更なし）"

if git remote get-url origin >/dev/null 2>&1; then
  git push -u origin HEAD
else
  gh repo create "$REPO" --public --source . --remote origin --push
fi

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
gh api -X POST "repos/$USER/$REPO/pages" -f "source[branch]=$BRANCH" -f "source[path]=/" >/dev/null 2>&1 \
  || gh api -X PUT "repos/$USER/$REPO/pages" -f "source[branch]=$BRANCH" -f "source[path]=/" >/dev/null 2>&1 || true

echo
echo "公開URL:  https://$USER.github.io/$REPO/"
echo "（はじめての ときは 1〜2分 まってから ひらいて ください）"
