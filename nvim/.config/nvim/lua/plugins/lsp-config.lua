return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
   {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      ensure_installed = {
        "tailwindcss",
        "lua_ls",
        "ts_ls",
        "pyright",
        "gopls",
      },
    },
  },
   {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- Configure diagnostics display
      vim.diagnostic.config({
        virtual_text = true,  -- Enable inline error text
        signs = true,         -- Show signs in gutter
        underline = true,     -- Underline errors
        update_in_insert = false, -- Don't update while typing
        severity_sort = true, -- Sort by severity
      })

      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities()
      )

      -- Configure LSP servers using new vim.lsp.config API
      vim.lsp.config.tailwindcss = {
        capabilities = capabilities,
      }
      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
      }
      vim.lsp.config.ts_ls = {
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      }
      vim.lsp.config.pyright = {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      }
      vim.lsp.config.gopls = {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      }

      -- Enable the configured servers
      vim.lsp.enable(vim.lsp.config.tailwindcss)
      vim.lsp.enable(vim.lsp.config.lua_ls)
      vim.lsp.enable(vim.lsp.config.pyright)
      vim.lsp.enable(vim.lsp.config.ts_ls)
      vim.lsp.enable(vim.lsp.config.gopls)

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
    end,
  },
}
