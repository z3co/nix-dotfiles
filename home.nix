{
  config,
  pkgs,
  ...
}: {
  home.username = "z3co";
  home.homeDirectory = "/home/z3co";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
    alejandra
  ];
  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
  in {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      nixd
      wl-clipboard
      tree-sitter
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        # config = toLuaFile ./config/nvim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = catppuccin-nvim;
      }

      neodev-nvim

      nvim-cmp
      {
        plugin = nvim-cmp;
        # config = toLuaFile ./config/nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        # config = toLuaFile ./config/nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets

      lualine-nvim
      nvim-web-devicons
      rustaceanvim

      nvim-treesitter
      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-go
        ]);
        # config = toLuaFile ./config/nvim/plugin/treesitter.lua;
      }

      vim-nix

      # {
      #   plugin = vimPlugins.own-onedark-nvim;
      #   config = "colorscheme onedark";
      # }
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./config/nvim/options.lua}
      ${builtins.readFile ./config/nvim/plugin/treesitter.lua}

      ${builtins.readFile ./config/nvim/plugin/lsp.lua}
      ${builtins.readFile ./config/nvim/plugin/telescope.lua}
      ${builtins.readFile ./config/nvim/plugin/cmp.lua}
      ${builtins.readFile ./config/nvim/plugin/colorscheme.lua}
    '';
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Jeppe Wolff Johansen";
        email = "jepper123411@proton.me";
      };
      init = {defaultBranch = "main";};
      commit.gpgsign = true;
      gpg.format = "openpgp";
      user.signingkey = "51F35AF7330E235B";
    };
  };
  programs.tmux.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -lA --color";
      cd = "z";
    };
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history = {
      path = "/home/z3co/.hist";
      saveNoDups = true;
      save = 10000;
      size = 10000;
      share = true;
    };
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "zoxide" "fzf"];
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
         exec start-hyprland
      fi
    '';
  };
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    configFile = ./config/ohmyposh/base.toml;
  };
  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/wofi".source = ./config/wofi;
  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/backgrounds".source = ./config/backgrounds;
  home.file.".config/tmux".source = ./config/tmux;
  home.file.".config/scripts".source = ./config/scripts;
}
