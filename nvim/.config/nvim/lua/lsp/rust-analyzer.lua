vim.lsp.config['rust-analyzer'] = {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust','rs' },
  root_markers = { 'Cargo.toml', '.git' },
}

