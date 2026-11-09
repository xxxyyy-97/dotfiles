# Shell Config

Общие настройки окружения (PATH, переменные) и алиасы для всех POSIX-совместимых шеллов (zsh, bash, sh).

Этот пакет разворачивается через GNU Stow в `$HOME/.config`, а не в корень домашней директории, чтобы соответствовать стандарту XDG Base Directory Specification.

## Содержание

- [Структура](#структура)
- [Как это работает](#как-это-работает)
- [Установка](#установка)
- [Подключение в rc-файлах](#подключение-в-rc-файлах)
- [Разделение ответственности](#разделение-ответственности)
- [Примеры добавления настроек](#примеры-добавления-настроек)
- [Требования](#требования)

---

## Структура
```text
shell/
├── .config/ # Зеркалит ~/.config после stow
├──── shell-init.sh # Точка входа (оркестратор)
├──── functions.sh # Определяет load_dotfiles_shell()
├──── env.sh # Экспорты PATH, EDITOR, NVM_DIR и т.д.
└──── aliases.sh # Только alias команды
```
После выполнения `stow shell` симлинки создаются так:

```text
~/.config/shell-init.sh -> ~/dotfiles/shell/.config/shell-init.sh
~/.config/functions.sh  -> ~/dotfiles/shell/.config/functions.sh
~/.config/env.sh        -> ~/dotfiles/shell/.config/env.sh
~/.config/aliases.sh    -> ~/dotfiles/shell/.config/aliases.sh
```
## Как это работает
1. Инициализация: Шелл (zsh или bash) читает свой .rc файл и встречает строку подключения shell-init.sh.
2. Загрузка функций: shell-init.sh определяет свою директорию ($HOME/.config) и соурсит functions.sh.
3. Вызов загрузчика: shell-init.sh вызывает функцию load_dotfiles_shell("$HOME/.config").
4. Цикл загрузки: Функция проходит по массиву скриптов (env.sh, aliases.sh) и подключает их через source.
5. Результат: Переменные окружения установлены, алиасы определены.

## Установка
Если ты клонируешь dotfiles на новую машину:
```bash
sudo apt install -y git stow
git clone git@github.com:xxxyyy-97/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Разворачиваем пакет shell
stow shell
```
Проверка симлинков:
```bash
ls -la ~/.config/*.sh
```
Должны быть видны ссылки на ~/dotfiles/shell/.config/...

## Подключение в rc-файлах
Чтобы настройки применялись автоматически, нужно добавить одну строку в конец каждого конфига шелла.

### Для Zsh/Bash итд (~/.zshrc, ~/.bashrc ...)
Добавляй в конец файла
```bash
# ... остальные настройки zsh ...

# Загрузка общих конфигураций (env + aliases)
[[ -f "$HOME/.config/shell-init.sh" ]] && source "$HOME/.config/shell-init.sh"
```
## Разделение ответственности
Мы строго разделяем типы настроек по файлам, чтобы избежать хаоса.
| Файл | Что здесь живет | Чего здесь НЕ должно быть |
|------|-----|----|
| env.sh | export VAR=value, изменение PATH, загрузка внешних инструментов (nvm, sdkman). | Алиасы, функции, интерактивные настройки. |
| aliases.sh | Только alias name='command'. | Экспорты, проверки существования бинарников (см. ниже). |
| functions.sh | Определение полезных функций шелла. | Глобальные экспорты, побочные эффекты при source.|
| shell-init.sh | Логика оркестрации (кто кого грузит). | Конкретные настройки пользователя. |

## Примеры добавления настроек
### Добавить новый инструмент в PATH
Открой shell/.config/env.sh:
```bash
# Добавляем Rust bin
if [[ -d "$HOME/.cargo/bin" ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi
```
### Добавить новый алиас
Открой shell/.config/aliases.sh:
```bash
# Короткий выход из tmux
alias tx="tmux kill-session -t main"
```
### Добавить новую функцию
Открой shell/.config/functions.sh:
```bash
# Быстрый поиск процесса
findproc() {
    ps aux | grep -i "$1" | grep -v grep
}
```
Не забудь добавить имя файла в массив scripts внутри load_dotfiles_shell, если создашь отдельный файл (например, completions.sh).

## Требования
Для корректной работы этого пакета на целевой машине должны быть установлены:
- GNU Stow (для создания симлинков).
- Любой POSIX-совместимый шелл (Bash >= 4.0, Zsh).
Инструменты, упоминаемые в env.sh (nvm, uv, pi-agent), опциональны. Скрипт проверит их наличие перед загрузкой, поэтому отсутствие этих программ не сломает старт шелла.
