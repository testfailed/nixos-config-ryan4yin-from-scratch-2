{ pkgs, config, ... }:

let
  withLang = lang: builtins.elem lang config.language-support;
in
{
  programs.nixvim = {
    enable = true;

    # colorschemes.tokyonight.enable = true;

    # Settings
    opts = {
      expandtab = true;
      tabstop = 8;
      softtabstop = 2;
      shiftwidth = 2;
      smartindent = true;
      number = true;
      relativenumber = true;
      clipboard = "unnamedplus";
      mouse = "";
    };

    # Keymaps
    globals = {
      mapleader = " ";
    };

    # Plugins
    plugins = {

      #
      # UI
      #

      lualine.enable = true;
      bufferline.enable = true;
      treesitter.enable = true;

      which-key = {
        enable = true;
      };

      # WARN: This is considered experimental feature.
      noice = {
        enable = true;
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          # inc_rename = false;
          # lsp_doc_border = false;
        };
      };

      telescope = {
        enable = true;
        settings.keymaps = {

          "<leader>ff" = {
            desc = "find files";
            action = "find_files";
          };

          "<leader>sg" = {
            desc = "search with grep";
            action = "live_grep";
          };

        };
      };

      extensions = {
        file-browser.enable = true;
      };
    };

    # LSP
    lsp = {
      enable = true;
      servers = {
        # hls.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        # rust-analyzer = {
        #   enable = true;
        #   installCargo = false;
        #   installRustc = false;
        # };
      };
    };

  };
}
