#!/bin/bash

# --- Загрузка персональных данных из ~/.env ---
# Это должно быть ПЕРВЫМ, чтобы переменные были доступны ниже.
if [[ -f "$HOME/.env" ]]; then
    # set -a включает автоматический экспорт всех переменных,
    # которые определяются после этой команды.
    set -a
    source "$HOME/.env"
    set +a
fi

# --- Editor ---
export EDITOR="nvim"

# --- System Paths ---
# Add local bin to PATH (for user-installed tools like uv, cargo, pip --user)
if [[ -d "$HOME/.local/bin" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# --- Pi Agent ---
# Only add to PATH if the directory exists and has binaries
PI_AGENT_BIN="$HOME/.pi/agent/bin"
if [ -d "$PI_AGENT_BIN" ] && [ "$(ls -A $PI_AGENT_BIN 2>/dev/null)" ]; then
    export PATH="$PI_AGENT_BIN:$PATH"
fi

# --- NVM (Node Version Manager) ---
# Only load if nvm is actually installed in ~/.nvm
if [ -s "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    . "$NVM_DIR/nvm.sh"
    # Optional: bash completion for nvm
    if [ -s "$NVM_DIR/bash_completion" ]; then
        . "$NVM_DIR/bash_completion"
    fi
fi

# --- DBT Profiles Dir ---
# Export only if dbt might be used (via uv or system install)
# Harmless if exported unconditionally, but cleaner with check
if command -v dbt >/dev/null 2>&1 || command -v uv >/dev/null 2>&1; then
    export DBT_PROFILES_DIR="$HOME/.dbt"
fi
