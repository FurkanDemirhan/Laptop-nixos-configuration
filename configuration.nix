# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:


let
  unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
    config = { allowUnfree = true; allowBroken = true; };
  };
  #aagl = import (builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz");
in

 
{
  imports =
    [ 
      ./hardware-configuration.nix
      #aagl.module
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.systemd-boot.editor = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  #boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.forceInstall = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_15;
  #boot.extraModulePackages = with pkgs.linuxKernel.packages.linux_6_15; [ v4l2loopback ];
  
  #boot.loader.systemd-boot.extraFiles {
  #  "efi/linux-zen/linux_zen.efi"
  
  
  
  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Turkey";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    #font = "Lat2-Terminus16";
    #keyMap = "tr";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  nixpkgs.config.permittedInsecurePackages = ["dotnet-sdk-6.0.428" "dotnet-runtime-6.0.36" "aspnetcore-runtime-6.0.36" "dotnet-sdk-7.0.120" "ventoy-full" "ventoy-1.1.05" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];  


  # Configure keymap in X11
  services.xserver.xkb.layout = "tr";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  #hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.extraGroups.plugdev = { };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.furkan = {
    isNormalUser = true;
    extraGroups = ["libvirtd" "wheel" "dialout" "disk" "video" "qemu" "kvm" "plugdev"]; # Enable ‘sudo’ for the user.
    password = "1234";
    shell = pkgs.fish;
    packages = with pkgs; [
    ];
  };

  virtualisation.libvirtd = {
  enable = true;
  qemu = {
    package = unstable.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
    ovmf = {
      enable = true;
      packages = [(unstable.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };
  

  virtualisation.waydroid.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.fish.enable = true;
  services.desktopManager.plasma6.enable = false;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
  services.fwupd.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  
  
  #programs.sleepy-launcher.enable = true;
  #programs.the-honkers-railway-launcher.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  programs.alvr.enable = true;
  programs.alvr.openFirewall = true;
  hardware.steam-hardware.enable = true;

  environment.systemPackages = with pkgs; [
    nano
    wget
    tree
    wayland
    xdg-desktop-portal-hyprland
    qt6.qtwayland
    qt6.qtbase
    unstable.waybar
    networkmanagerapplet
    blueman
    xfce.thunar
    hyprshot
    wofi
    wl-clipboard
    sudo
    fish
    alacritty
    #unstable.jetbrains.rider
    #dotnet-sdk_9
    #dotnet-runtime_9
    #dotnet-aspnetcore_9
    fontconfig
    gtk3
    unstable.wineWow64Packages.full
    unstable.winetricks
    btop
    unstable.qemu
    steam
    protonup-qt
    steam-unwrapped
    unstable.llama-cpp
    #dotnetPackages.Nuget
    git
    steam-run
    android-tools
    brightnessctl
    #heimdall
    #heimdall-gui
    lz4
    p7zip
    qbittorrent
    cmake
    unstable.heroic
    jdk
    cava
    aria
    fastfetch
    vlc
    ffmpeg-full
    krita
    hyprland-protocols
    unstable.blender
    python314Full
    python310Full
    libresprite
    kdePackages.kate
    adwaita-icon-theme
    hyprpolkitagent
    udisks2
    unstable.mesa
    unstable.mesa-demos
    unstable.vulkan-loader
    unstable.vulkan-tools
    unstable.vulkan-validation-layers
    python3Packages.setuptools
    python3
    flatpak
    librewolf
    unstable.zapzap
    cheese
    usbutils
    tor-browser
    cdrtools
    ungoogled-chromium
    pavucontrol
    mangohud
    grim
    xfce.thunar-volman
    mtpfs
    xfce.thunar-media-tags-plugin
    android-file-transfer
    gamemode
    gamescope
    gnumake
    unstable.vesktop
    adwaita-qt6
    qt6ct
    swww
    hyprpicker
    hyprutils
    gifsicle
    linuxKernel.packages.linux_zen.kernel  
    efibootmgr
    grub2_efi
    grub2
    eww
    exfat
    exfatprogs
    xarchiver
    jre17_minimal
    unstable.arduino-ide
    xorg.xkill
    filezilla
    unstable.lact
    minicom
    lzip
    gthumb
    bc
    esptool
    espflash
    appimage-run
    unrar
    unstable.jetbrains.rust-rover
    unstable.jetbrains.clion
    rustup
    killall
    ninja
    alsa-lib
    alsa-oss
    alsa-utils
    alsa-tools
    unstable.telegram-desktop
    unstable.vscodium
    kdePackages.okular
    unzip
    unstable.teams-for-linux
    helvum
    weston
    openssl
    rPackages.pkgconfig
    util-linux
    zlib
    unstable.spice
    unstable.libdrm
    unstable.rPackages.gbm
    cage
    protontricks
    meson
    tio
    putty
    premake5
    pkgsCross.mingw32.stdenv.cc
    unstable.ghidra-bin
    unstable.ghidra-extensions.wasm
    unstable.ghidra-extensions.kaiju
    unstable.ghidra-extensions.ret-sync
    unstable.ghidra-extensions.findcrypt
    unstable.ghidra-extensions.lightkeeper
    unstable.ghidra-extensions.machinelearning
    unstable.ghidra-extensions.gnudisassembler
    unstable.ghidra-extensions.ghidra-delinker-extension
    unstable.ghidra-extensions.ghidraninja-ghidra-scripts
    unstable.lutris
    clang
    #ida-free
    unstable.obs-studio
    unstable.lmstudio
    ventoy-full
    unstable.mcpelauncher-client
    unstable.mcpelauncher-ui-qt
    wimlib
    chntpw
    ryubing
    dmg2img
    libarchive
    syslinux
    unstable.ironbar
    swaynotificationcenter
    unstable.anydesk
    hyprlandPlugins.hyprbars
    dwarfs
    kdePackages.filelight
    hyprpaper
    gammastep
    helix
    gparted
    udiskie
    unstable.sidequest
    scrcpy
    xorg.xcbutil
    xorg.xcbutilcursor
    xorg.xcbutilerrors
    xorg.xcbutilwm
    xorg.xcbutilkeysyms
    xorg.xcbutilimage
    xorg.xcbutilrenderutil
    xorg.xprop
    xorg.xdpyinfo
    libva
    libva-utils
    intel-media-driver
];



  fonts.packages = with pkgs; [
    minecraftia
    noto-fonts
    comic-mono
    fira-code
    fira-code-symbols
    noto-fonts-emoji
    noto-fonts-cjk-sans
    liberation_ttf
    #google-fonts
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  environment.variables = {
    "OPENSSL_CONF" = "/etc/nixos/openssl.conf";
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    #QT_QPA_PLATFORM = "steam-run xcb ~/.local/share/Steam/steamapps/common/SteamVR/bin/vrmonitor.sh %command%";    
  };
  environment.sessionVariables = {
    "OPENSSL_CONF" = "/etc/nixos/openssl.conf";
     GTK_THEME = "Adwaita:dark";
     QT_QPA_PLATFORMTHEME = "qt6ct";
     #QT_QPA_PLATFORM = "steam-run xcb ~/.local/share/Steam/steamapps/common/SteamVR/bin/vrmonitor.sh %command%";
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"
    # add more rules for your device if necessary
  '';
  
  #services.udev.packages = with pkgs; [
  #  steam-devices-udev-rules
  #
  #];

  services.thermald.enable = true;
  services.logind.lidSwitch = "suspend-then-hibernate";
  services.logind.powerKey = "ignore";
  services.logind.powerKeyLongPress = "ignore";
#  services.logind.lidSwitch = "ignore";
  services.teamviewer.enable = true;  
  services.flatpak.enable = true;
  services.udisks2.enable = true;
  nixpkgs.config.android_sdk.accept_license = true;  
  services.udev.enable = true;
  services.power-profiles-daemon.enable = true;
  services.blueman.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.graphics.enable32Bit = true;  # Enables 32-bit OpenGL support for Wine
  hardware.pulseaudio.support32Bit = true; # Enables 32-bit audio support for Wine
  hardware.opengl.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;
  security.pki.certificateFiles = [
    ./MEB_SERTIFIKASI.crt
  ];

  networking.extraHosts = ''
    142.250.184.238 restrict.youtube.com
  '';
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}


