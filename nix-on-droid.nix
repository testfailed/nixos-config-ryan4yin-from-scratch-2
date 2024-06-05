{ config, lib, pkgs, ... }:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    # Core Tools
    bzip2
    coreutils
    curlFull
    diffutils
    findutils
    git
    gnugrep
    gnupg
    gnused
    gnutar
    gzip
    hostname
    man
    openssh
    tzdata
    unzip
    utillinux
    vim
    wget
    xz
    zip

    # User Tools
    bat
    bat-extras.batdiff
    bat-extras.batgrep
    bat-extras.batman
    bat-extras.batpipe
    bat-extras.batwatch
    bat-extras.prettybat
    delta
    eza
    fzf
    neovim
    nodejs
    tmux
    zoxide
    zsh

    # Development Tools
    python3
    # nodejs
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".before-nix-on-droid";

  # Read the changelog before changing this value
  system.stateVersion = "23.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Asia/Seoul";
}
