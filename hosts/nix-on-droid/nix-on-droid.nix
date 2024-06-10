{ pkgs, config, ... }:

{
  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".before-nix-on-droid";

  # Read the changelog before changing this value
  system.stateVersion = "22.11";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Asia/Seoul";

  nixpkgs.overlays = [ ];

  home-manager.config =
    { pkgs, ... }:
    {
      # system.os = "Nix-on-Droid";
      home.stateVersion = "22.11";
      # nixpkgs.overlays = config.nixpkgs.overlays;
      # imports = [
      # ../../home/config/identity.nix
      # ../../home/assorted-tools.nix
      # ../../home/bash.nix
      # ../../home/bat.nix
      # ../../home/common.nix
      # ../../home/eza.nix
      # ../../home/git.nix
      # ../../home/htop.nix
      # ../../home/mosh.nix
      # ../../home/neovim.nix
      # ../../home/ssh.nix
      # ../../home/tmux.nix
      # ../../home/zsh.nix

      # ../../home/python.nix
      # ];

      # home.packages = with pkgs; [ neovim ];
    };

  # supervisord.enable = true;
  # services.openssh.enable = true;

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
    # neovim
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
}
