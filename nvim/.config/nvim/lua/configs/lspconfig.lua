require("nvchad.configs.lspconfig").defaults()

vim.filetype.add({
  pattern = {
    [".*/%.github/workflows/.*%.ya?ml"] = "yaml.ghaction",
  },
})

vim.lsp.config("terraformls", {
  filetypes = { "terraform", "terraform-vars", "hcl" },
})

vim.lsp.config("tflint", {
  filetypes = { "terraform", "terraform-vars" },
})

vim.lsp.config("gopls", {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, { "go.work", "go.mod", ".git" })
      or vim.fs.dirname(fname)
    on_dir(root)
  end,
})

vim.lsp.config("pyright", {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      ".git",
    }) or vim.fs.dirname(fname)
    on_dir(root)
  end,
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
      },
    },
  },
})

vim.lsp.config("ansiblels", {
  filetypes = { "yaml", "yaml.ansible" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, { "ansible.cfg", ".ansible-lint" })
      or vim.fs.dirname(fname)
    on_dir(root)
  end,
})

vim.lsp.config("yamlls", {
  filetypes = { "yaml", "yaml.ansible" },
})

vim.lsp.config("ts_ls", {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, {
      "tsconfig.json",
      "jsconfig.json",
      "package.json",
      ".git",
    }) or vim.fs.dirname(fname)
    on_dir(root)
  end,
})

vim.lsp.config("clangd", {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, {
      "compile_commands.json",
      "compile_flags.txt",
      ".clangd",
      ".git",
    }) or vim.fs.dirname(fname)
    on_dir(root)
  end,
})

local servers = {
  "html",
  "cssls",
  "terraformls",
  "tflint",
  "gopls",
  "pyright",
  "ts_ls",
  "ansiblels",
  "yamlls",
  "clangd",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
