local arrows = { '<Up>', '<Down>', '<Left>', '<Right>' }
local modes = { 'n', 'v' } -- n=normal, v=visual, i=insert, c=command

for _, mode in ipairs(modes) do
  for _, key in ipairs(arrows) do
    vim.keymap.set(mode, key, '<Nop>')
  end
end

-- маппинд (о,р,л,д) ->(h,j,k,l)
local mappings = {
  ['р'] = 'h',
  ['о'] = 'j',
  ['л'] = 'k',
  ['д'] = 'l',
  ['ш'] = 'i',
}

for mode, keys in pairs({
  n = mappings,  -- Normal mode
  v = mappings,  -- Visual mode
  o = mappings,  -- Operator-pending mode
}) do
  for ru, en in pairs(keys) do
    vim.keymap.set(mode, ru, en)
  end
end
