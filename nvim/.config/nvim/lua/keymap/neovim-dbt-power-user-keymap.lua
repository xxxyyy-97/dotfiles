local map_array = require("utils.keymap").map_array
local prefix = require("dbt-power-user.config").options.prefix

local unpack = unpack or table.unpack

local function dbt_cmd(module, fn, ...)
  local args = { ... }
  local n = select("#", ...)          -- помним реальное число аргументов, включая nil
  return function()
    require("dbt-power-user." .. module)[fn](unpack(args, 1, n))
  end
end

local DBT_ACTIONS = {
  -- === Запуск и сборка ===
  { key = 'r', desc = 'Запустить текущую модель',                 fn = dbt_cmd('commands', 'run_model', 'current') },
  { key = 'R', desc = 'Запустить текущую и зависимости вниз',     fn = dbt_cmd('commands', 'run_model', 'downstream') },
  { key = 'u', desc = 'Запустить зависимости вверх и текущую',    fn = dbt_cmd('commands', 'run_model', 'upstream') },
  { key = 'b', desc = 'Собрать (build) текущую модель',           fn = dbt_cmd('commands', 'build_model', 'current') },
  { key = 't', desc = 'Протестировать текущую модель',            fn = dbt_cmd('commands', 'test_model') },

  -- === Компиляция и предпросмотр ===
  { key = 'c', desc = 'Скомпилировать и показать SQL',            fn = dbt_cmd('compile', 'preview') },
  { key = 'p', mode = 'n', desc = 'Предпросмотр результатов (весь буфер)',      fn = dbt_cmd('show', 'preview_query') },
  { key = 'p', mode = 'v', desc = 'Предпросмотр результатов (выделенный текст)', fn = dbt_cmd('show', 'preview_query', { range = true }) },

  -- === Граф зависимостей (Lineage) ===
  { key = 'l', desc = 'Показать граф зависимостей (дерево)',      fn = dbt_cmd('lineage', 'show_tree', nil) },
  { key = 'L', desc = 'Пикер зависимостей вверх (ancestors)',     fn = dbt_cmd('lineage', 'show_picker', nil, 'ancestors') },
  { key = 'W', desc = 'Пикер зависимостей вниз (descendants)',    fn = dbt_cmd('lineage', 'show_picker', nil, 'descendants') },

  -- === Навигация ===
  { key = 'g', desc = 'Перейти к определению (ref/source)',       fn = dbt_cmd('definition', 'goto_under_cursor') },
  { key = 'k', desc = 'Информация под курсором (Hover)',          fn = dbt_cmd('hover', 'show') },

  -- === Пикеры ===
  { key = 'm', desc = 'Список всех моделей',                      fn = dbt_cmd('picker', 'models') },
  { key = 's', desc = 'Список всех источников',                   fn = dbt_cmd('picker', 'sources') },
  { key = 'M', desc = 'Список всех макросов',                     fn = dbt_cmd('picker', 'macros') },
  { key = 'h', desc = 'История последних запусков',               fn = dbt_cmd('picker', 'run_history') },

  -- === Документация и прочее ===
  { key = 'D', desc = 'Переключить defer to prod',                fn = dbt_cmd('defer', 'toggle') },
  { key = 'o', desc = 'Открыть документацию в браузере',          fn = dbt_cmd('docs', 'open') },
  { key = 'G', desc = 'Сгенерировать документацию',               fn = dbt_cmd('docs', 'generate') },
  { key = 'a', desc = 'Палитра всех действий',                    fn = dbt_cmd('picker', 'actions') },
}

map_array(DBT_ACTIONS, {
  prefix = prefix,          -- клавиши: prefix .. key — в одном месте
  desc_prefix = 'dbt: ',    -- описания: "dbt: ..." — в одном месте
})
