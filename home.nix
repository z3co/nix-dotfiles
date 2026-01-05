{ config, pkgs, ... }:

{
  home.username = "z3co";
  home.homeDirectory = "/home/z3co";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  programs.git = {
		enable = true;
		userName = "z3co";
		userEmail = "jepper123411@proton.me";
		extraConfig = {
			init = { defaultBranch = "main"; };
			commit.gpgsign = true;
			gpg.format = "ssh";
			user.signingkey = "~/.ssh/id_ed25519.pub";
		};
	};
	programs.tmux.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll="ls -lA --color";
      cd="z";
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
      plugins = [ "git" "zoxide" "fzf" ];
    };
    profileExtra = ''
      export EDITOR=nvim
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
	start-hyprland
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
	home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/nvim";
  home.file.".config/wofi".source = ./config/wofi;
  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/backgrounds".source = ./config/backgrounds;
  home.file.".config/tmux".source = ./config/tmux;
  home.file.".config/scripts".source = ./config/scripts;
}
