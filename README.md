# dotfiles

Мои конфиги: Neovim, zsh и прочее. Хранятся в одном репозитории,
разворачиваются через GNU Stow (симлинки в `$HOME`).

## Содержание

- [Структура](#структура)
- [Требования](#требования)
- [Установка на новой машине](#установка-на-новой-машине)
- [Как редактировать](#как-редактировать)
- [Как добавить новый конфиг](#как-добавить-новый-конфиг)
- [Локальные override-файлы](#локальные-override-файлы)
- [Ветки](#ветки)
- [Чего не коммитить](#чего-не-коммитить)
- [Полезные команды stow](#полезные-команды-stow)

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
```bash
sudo apt update
sudo apt install -y git stow

git clone git@github.com:xxxyyy-97/dotfiles.git ~/dotfiles
cd ~/dotfiles

stow nvim
stow zsh
```
Проверка:
```bash
ls -la ~/.config/nvim
ls -la ~/.zshrc
```
Должны быть симлинки в ~/dotfiles.

## Как редактировать
Редактируй файлы как обычно — через ~/.config/nvim/... или ~/.zshrc.
Из-за симлинка изменения физически попадают в репозиторий.
Потом:
```bash
cd ~/dotfiles
git status
git add .
git commit -m "..."
git push
```
## Как добавить новый конфиг
Например, tmux:
```bash
cd ~/dotfiles
mkdir tmux
# кладём конфиг так, как он лежит относительно $HOME
# для ~/.tmux.conf:
touch tmux/.tmux.conf
# для ~/.config/tmux/tmux.conf:
# mkdir -p tmux/.config/tmux && touch tmux/.config/tmux/tmux.conf

stow tmux
```
## Локальные override-файлы
Некоторые вещи не должны попадать в Git: токены, пути, machine-specific настройки.
- ~/.zshrc.local — подключается в конце ~/.zshrc, не в Git.
- ~/.config/nvim/local.lua — если используешь, добавлен в .gitignore.
Пример: отключить авто-установку pyright на машине без npm:
```bash
echo 'export NVIM_DISABLE_PYRIGHT=1' >> ~/.zshrc.local
source ~/.zshrc
```
## Ветки
- main — базовый конфиг для большинства машин.
- pihole — правки под сервер с AdGuard Home (в частности, отключён pyright,
т.к. там нет npm и Python-LSP не нужен). Не мёржится в main, живёт отдельно.
На других машинах работай в main.

## Чего не коммитить
- приватные SSH-ключи (~/.ssh/id_*);
- токены, пароли, .env;
- ~/.aws, ~/.azure, ~/.password-store и подобные;
- любые секреты.

## Полезные команды stow
```bash
stow <pkg>        # создать симлинки
stow -D <pkg>     # удалить симлинки (файлы в репо остаются)
stow -R <pkg>     # пересоздать (удалить + создать)
```
