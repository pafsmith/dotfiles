return {
  -- LSP and completion
  require("plugins.lsp-config"),
  require("plugins.completions"),

  -- UI and themes
  require("plugins.catppuchin"),

  -- Editor enhancements
  require("plugins.telescope"),
  require("plugins.neo-tree"),
  require("plugins.treesitter"),
  require("plugins.lua-line"),
  require("plugins.snacks"),
  require("plugins.which-key"),
}
