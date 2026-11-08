#!/usr/bin/env bash

# need: chmod +x gitconfig.sh 

set -euo pipefail

# Если есть локальный ~/.env, подтягиваем переменные из него.
# Сам ~/.env в git не коммитим.
if [[ -f "$HOME/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "$HOME/.env"
  set +a
fi

gc() {
  git config --global "$@"
}

# Базовые настройки
gc init.defaultBranch main
gc core.editor nvim
gc color.ui auto

# Merge / mergetool
gc merge.conflictStyle zdiff3
gc merge.tool nvimdiff4
gc mergetool.keepBackup false
# 4-панельный
gc mergetool.nvimdiff4.cmd 'nvim -d "$LOCAL" "$BASE" "$REMOTE" "$MERGED"'
# 3-панельный
# gc mergetool.nvimdiff4.cmd 'nvim -d "$LOCAL" "$REMOTE" "$MERGED"'
gc mergetool.nvimdiff4.trustExitCode true

# Запоминать разрешения конфликтов
gc rerere.enabled true

# Алиасы
# gc alias.st status -sb
# gc alias.co checkout
# gc alias.br branch -vv
# gc alias.lg 'log --oneline --graph --decorate'

# Персональные данные берём из окружения, чтобы не коммитить их в скрипт.
if [[ -n "${GIT_AUTHOR_NAME:-}" ]]; then
  gc user.name "$GIT_AUTHOR_NAME"
fi

if [[ -n "${GIT_AUTHOR_EMAIL:-}" ]]; then
  gc user.email "$GIT_AUTHOR_EMAIL"
fi

if [[ -n "${GITHUB_USER:-}" ]]; then
  gc github.user "$GITHUB_USER"
fi
