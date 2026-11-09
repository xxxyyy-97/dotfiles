#!/bin/bash

# Функция принимает путь к директории с конфигами как первый аргумент
load_dotfiles_shell() {
    local config_dir="${1:-$HOME/.config}" # Дефолтное значение, если аргумент не передан
    
    local scripts=(
        "env.sh"
        "aliases.sh"
    )

    for script in "${scripts[@]}"; do
        local file_path="$config_dir/$script"
        if [[ -f "$file_path" ]]; then
            source "$file_path"
        fi
    done
}
