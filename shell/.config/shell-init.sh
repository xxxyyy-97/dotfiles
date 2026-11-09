#!/bin/bash

# Определяем директорию, где лежит этот самый файл (shell-init.sh)
# Обычно это ~/.config, но можно вычислить динамически, если нужно
# SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR="$HOME/.config"

# Загружаем определения функций
if [[ -f "$SCRIPT_DIR/functions.sh" ]]; then
    source "$SCRIPT_DIR/functions.sh"
fi

# Вызываем загрузчик, передавая ему ту же директорию
# Теперь load_dotfiles_shell знает, откуда брать env.sh и aliases.sh
if declare -f load_dotfiles_shell > /dev/null; then
    load_dotfiles_shell "$SCRIPT_DIR"
else
    echo "Error: load_dotfiles_shell function not found." >&2
    return 1 # или exit 1, в зависимости от контекста вызова
fi
