local M = {}

M.linters_by_ft = {
  c = { "cpplint" },
  cpp = { "cpplint" },
  terraform = { "tflint" },
  hcl = { "tflint" },
  python = { "ruff" },
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  html = { "htmlhint" },
  c = { "clangtidy", "cppcheck", "cpplint" },
  cpp = { "clangtidy", "cppcheck", "cpplint" },
  yaml = { "yamllint" },
  ["yaml.ansible"] = { "ansible_lint", "yamllint" },
  ansible = { "ansible_lint" },
  ["yaml.ghaction"] = { "actionlint" },
}

function M.setup()
  local lint = require "lint"
  lint.linters_by_ft = M.linters_by_ft

  local lint_group = vim.api.nvim_create_augroup("UserCpplintOnSave", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = lint_group,
    pattern = {
      "*.c",
      "*.cc",
      "*.cpp",
      "*.cxx",
      "*.h",
      "*.hh",
      "*.hpp",
      "*.hxx",
      "*.py",
      "*.js",
      "*.jsx",
      "*.ts",
      "*.tsx",
      "*.html",
      "*.c",
      "*.cc",
      "*.cpp",
      "*.cxx",
      "*.h",
      "*.hh",
      "*.hpp",
      "*.hxx",
      "*.yml",
      "*.yaml",
    },
    callback = function()
      if vim.bo.buftype ~= "" then
        return
      end

      pcall(lint.try_lint, nil, { ignore_errors = true })
    end,
  })
end

return M
