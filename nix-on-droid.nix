{ config, lib, pkgs, ... }:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    bat
    bzip2
    coreutils
    delta
    diffutils
    findutils
    fzf
    git
    gnugrep
    gnupg
    gnused
    gnutar
    gzip
    hostname
    man
    neovim
    nodejs
    openssh
    python3
    tmux
    tzdata
    unzip
    utillinux
    vim
    xz
    zip
    zsh
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "23.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  #time.timeZone = "Europe/Berlin";
}
