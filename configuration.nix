# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# This is slightly jank, clean it at some point and remove this line

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Don't Use the gummiboot efi boot loader.
  boot.loader.grub.device = "/dev/sdc";
  boot.kernelPackages = pkgs.linuxPackages_4_1;
  networking.hostName = "muskeg"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
   };

  # Set your time zone.
    time.timeZone = "America/Detroit";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
   nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs;
    [
	gimp
	i3status
	steam
	vim
	arandr
	rxvt_unicode-with-plugins
	screenfetch	
	irssi
	glxinfo
	chromium    
	lm_sensors
#	haskellPackages.xmobar
#	haskellPackages.xmonad
#	haskellPackages.xmonad-contrib
	xscreensaver
	xorg.libX11
	perlPackages.X11GUITest
	pciutils
	compton
];


  # hardware crap
    hardware.opengl.driSupport32Bit = true;
    hardware.pulseaudio.systemWide = true;
    hardware.pulseaudio.support32Bit = true;
    hardware.enableAllFirmware = true;   
    hardware.opengl.s3tcSupport = true;

  # List services that you want to enable:

	# The pit of graphics settings, where tears are shed and all hope may be lost
		services.xserver.videoDrivers = ["ati_unfree"];
  # Enable the OpenSSH daemon.
    services.openssh.enable = true;
    services.openssh.permitRootLogin = "no";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # i3!
    services.xserver.windowManager.i3.enable = true;
 
	# Awesome
	# services.xserver.windowManager.awesome.enable = true;	
 
	# xmonad 4lyfe
#	services.xserver = 
#{ 
	#services.xserver.windowManager.xmonad.enable = true;  
	#services.xserver.windowManager.default = "xmonad";
#};
#	systemd.user.services."compton" = {
#		enable = true;
#		serviceConfig.Type = "forking";
#					  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
	
    users.extraUsers.saktrai = 
{
	isNormalUser = true;
	home = "/home/saktrai";
	extraGroups = ["wheel" "audio" "video" "networkmanager"];
};

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}
