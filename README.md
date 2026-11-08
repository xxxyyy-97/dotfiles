# dotfiles

Мои конфиги: Neovim, zsh и прочее. Хранятся в одном репозитории,
разворачиваются через GNU Stow (симлинки в `$HOME`).

## Структура

```text
.
├── nvim/          # ~/.config/nvim
├── zsh/           # ~/.zshrc
├── .gitignore
└── README.md
```
Каждая папка верхнего уровня — это пакет stow. Внутри него
структура повторяет путь относительно $HOME.

## Требования
- git
- stow (GNU Stow)

Для Neovim-конфига дополнительно (по желанию):
- neovim >= 0.12
- fzf, ripgrep, bat, fd — для fzf-lua
- lazygit — для lazygit-плагина
- nodejs + npm — если нужен pyright через Mason

## Установка на новой машине
