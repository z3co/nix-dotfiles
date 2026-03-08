{
config,
lib,
pkgs,
...
}: {
	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos-btw"; # Define your hostname.
	nixpkgs.config.allowUnfree = true;

	networking.networkmanager.enable = true;

	time.timeZone = "Europe/Copenhagen";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		keyMap = "dk";
	};

	programs.niri.enable = true;
	hardware.graphics.enable = true;
	hardware.graphics.enable32Bit = true;
	services.xserver.videoDrivers = ["nvidia"];
	hardware.nvidia = {
		powerManagement.enable = true;
		modesetting.enable = true;
		open = true;
	};
	hardware.bluetooth.enable = true;
	programs.virt-manager.enable = true;

	users.groups.libvirtd.members = ["z3co"];
	virtualisation.libvirtd.enable = true;
	virtualisation.spiceUSBRedirection.enable = true;

	users.users.z3co = {
		isNormalUser = true;
		extraGroups = ["wheel" "docker"];
		initialPassword = "123";
		shell = pkgs.zsh;
	};

	services.xserver.xkb.layout = "dk";

	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};
	services.flatpak.enable = true;
	services.kanata = {
		enable = true;
		keyboards.default.configFile = ./config/kanata/config.kbd;
	};
	services.twingate.enable = true;
	services.displayManager.sessionPackages = [ 
		pkgs.niri
	];
	services.displayManager.ly = {
		enable = true;
		settings = {
			animate = true;
			animation = 1;
			hide_borders = true;
		};
	};
	programs.zsh.enable = true;
	programs.neovim.defaultEditor = true;
	programs.steam.enable = true;
	programs.steam.gamescopeSession.enable = true;
	programs.gamemode.enable = true;

	virtualisation.docker.enable = true;

	fonts.fontDir.enable = true;

	programs.gnupg.agent= {
		enable = true;
		enableSSHSupport = true;
		pinentryPackage = pkgs.pinentry-curses;
	};

	security.pam.services = {
		login.u2fAuth = true;
		sudo.u2fAuth = true;
	};
	security.pam.u2f = {
		enable = true;
		settings.cue = true;
		settings.authfile = "/etc/secure-keys/u2f_keys";
	};
	services.pcscd.enable = true;
	services.udev.packages = [ pkgs.yubikey-personalization ];

	environment.pathsToLink = [ "/share/wayland-sessions" ];
	environment.systemPackages = with pkgs; [
		cmatrix
		wget
		kitty
		fzf
		zoxide
		banana-cursor
		mangohud
		protonup-ng
		pass
		wl-clipboard
		yubikey-manager
		yubico-piv-tool
		vicinae
		just
		pulseaudio
		xwayland-satellite
		alacritty
		fuzzel
		niri
		(callPackage ./packages/imagineer.nix {})
	];

	nix.settings.experimental-features = ["nix-command" "flakes"];

	system.stateVersion = "25.11"; # Did you read the comment?
}
