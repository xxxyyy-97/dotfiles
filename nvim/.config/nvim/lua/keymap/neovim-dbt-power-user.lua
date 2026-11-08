local prefix = require("dbt-power-user.config").options.prefix

local function dbt_cmd(module, fn, ...)
  local args = { ... }
  return function()
    require("dbt-power-user." .. module)[fn](unpack(args))
  end
end

local DBT_ACTIONS = {
  -- === Запуск и сборка ===
  { key = "r", desc = "dbt: Запустить текущую модель", fn = dbt_cmd("commands", "run_model", "current") },
  { key = "R", desc = "dbt: Запустить текущую и зависимости вниз", fn = dbt_cmd("commands", "run_model", "downstream") },
  { key = "u", desc = "dbt: Запустить зависимости вверх и текущую", fn = dbt_cmd("commands", "run_model", "upstream") },
  { key = "b", desc = "dbt: Собрать (build) текущую модель", fn = dbt_cmd("commands", "build_model", "current") },
  { key = "t", desc = "dbt: Протестировать текущую модель", fn = dbt_cmd("commands", "test_model") },

  -- === Компиляция и предпросмотр ===
  { key = "c", desc = "dbt: Скомпилировать и показать SQL", fn = dbt_cmd("compile", "preview") },
  { key = "p", mode = "n", desc = "dbt: Предпросмотр результатов (весь буфер)", fn = dbt_cmd("show", "preview_query") },
  { key = "p", mode = "v", desc = "dbt: Предпросмотр результатов (выделенный текст)", fn = dbt_cmd("show", "preview_query", { range = true }) },

  -- === Граф зависимостей (Lineage) ===
  { key = "l", desc = "dbt: Показать граф зависимостей (дерево)", fn = dbt_cmd("lineage", "show_tree", nil) },
  { key = "L", desc = "dbt: Пикер зависимостей вверх (ancestors)", fn = dbt_cmd("lineage", "show_picker", nil, "ancestors") },
  { key = "W", desc = "dbt: Пикер зависимостей вниз (descendants)", fn = dbt_cmd("lineage", "show_picker", nil, "descendants") },

  -- === Навигация ===
  { key = "g", desc = "dbt: Перейти к определению (ref/source)", fn = dbt_cmd("definition", "goto_under_cursor") },
  { key = "k", desc = "dbt: Информация под курсором (Hover)", fn = dbt_cmd("hover", "show") },

  -- === Пикеры (меню выбора) ===
  { key = "m", desc = "dbt: Список всех моделей", fn = dbt_cmd("picker", "models") },
  { key = "s", desc = "dbt: Список всех источников", fn = dbt_cmd("picker", "sources") },
  { key = "M", desc = "dbt: Список всех макросов", fn = dbt_cmd("picker", "macros") },
  { key = "h", desc = "dbt: История последних запусков", fn = dbt_cmd("picker", "run_history") },

  -- === Документация и прочее ===
  { key = "D", desc = "dbt: Переключить defer to prod", fn = dbt_cmd("defer", "toggle") },
  { key = "o", desc = "dbt: Открыть документацию в браузере", fn = dbt_cmd("docs", "open") },
  { key = "G", desc = "dbt: Сгенерировать документацию", fn = dbt_cmd("docs", "generate") },
  { key = "a", desc = "dbt: Палитра всех действий", fn = dbt_cmd("picker", "actions") },
}

for _, action in ipairs(DBT_ACTIONS) do
  local mode = action.mode or "n"
  local keys = prefix .. action.key
  vim.keymap.set(mode, keys, action.fn, {
    desc = action.desc,
    noremap = true,
    silent = true
  })
end
