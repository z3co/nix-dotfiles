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
		timewarrior
		fd
	];
	programs.neovim = {
		enable = true;
		defaultEditor = true;

		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		extraPackages = with pkgs; [
			wl-clipboard
			gcc
			gnumake
			nodejs
			tree-sitter
			ripgrep
			lua5_1
			luarocks
			go
			# LSP servers
			nixd
			lua-language-server
			gopls
			tinymist
			stylua
			gofumpt
			golangci-lint
		];
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
			user.signingkey = "1360D48A39CC2667";
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
		plugins = [
			{
				name = "fzf-tab";
				src = pkgs.zsh-fzf-tab;
				file = "share/fzf-tab/fzf-tab.plugin.zsh";
			}
		];
	};
	programs.oh-my-posh = {
		enable = true;
		enableZshIntegration = true;
		configFile = ./config/ohmyposh/base.toml;
	};
	xdg.configFile."nvim" = {
		source = config.lib.file.mkOutOfStoreSymlink "/home/z3co/nixos-dotfiles/config/nvim/";
	};
	home.file.".config/hypr".source = ./config/hypr;
	home.file.".config/waybar".source = ./config/waybar;
	home.file.".config/wofi".source = ./config/wofi;
	home.file.".config/kitty".source = ./config/kitty;
	home.file.".config/backgrounds".source = ./config/backgrounds;
	home.file.".config/tmux".source = ./config/tmux;
	home.file.".config/scripts".source = ./config/scripts;
}
