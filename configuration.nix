# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# BASICS
 # Boot via Grub2
	boot.loader.grub.device = "/dev/sdc";
 # Kernel Version
	boot.kernelPackages = pkgs.linuxPackages_4_4;
 # Hostname
 	networking.hostName = "muskeg";
 # Wifi   
	networking.wireless.enable = true;
 # Locale stuff
	i18n = 
	{
	 consoleFont = "Lat2-Terminus16";
	 consoleKeyMap = "us";
     	 defaultLocale = "en_US.UTF-8";
   	};
 # Timezone
	time.timeZone = "America/Detroit";


# PACKAGES
   	nixpkgs.config.allowUnfree = true;
   	environment.systemPackages = with pkgs;
   	 [
	# Desktop / X11 / WM
		i3status
		compton
		rxvt_unicode-with-plugins
		screenfetch
	# Applications
		vim
		chromium
		irssi
		git
		celestia
	# Utilities
		glxinfo  
		lm_sensors
		pciutils
		curl
		ncurses
		lzop
		lz4
		arandr
	# Dev
		gcc
		clang
		llvm
	# Games
		steam
		dwarf-fortress
		openttd
		openmw
		openra
	];


# CONFIG
 # Hardware
	hardware.opengl.driSupport32Bit = true;
	hardware.pulseaudio.systemWide = true;
	hardware.pulseaudio.support32Bit = true;
 	hardware.enableAllFirmware = true;   
 	hardware.opengl.s3tcSupport = true;
 # Services
 # Video Driver {"ati","ati_unfree","modesetting"}
	services.xserver.videoDrivers = ["ati"];
 # Enable the OpenSSH daemon.
	services.openssh.enable = true;
	services.openssh.permitRootLogin = "no";
 #  Enable CUPS to print documents.
	#services.printing.enable = true;
 # Enable the X11 windowing system.
	services.xserver.enable = true;
	services.xserver.layout = "us";
	# services.xserver.xkbOptions = "eurosign:e";
 # Window Manager
	services.xserver.windowManager.i3.enable = true;
	# services.xserver.windowManager.awesome.enable = true;
	# services.xserver.windowManager.xmonad.enable = true;  
	# services.xserver.windowManager.default = "xmonad";
 #	systemd.user.services."compton" = {
 #		enable = true;
 #		serviceConfig.Type = "forking";
 #					  };

# USR
    users.extraUsers.jrkristo = 
{
	isNormalUser = true;
	home = "/home/jrkristo";
	extraGroups = ["wheel" "audio" "video" "networkmanager"];
};

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}
