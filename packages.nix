{ pkgs, ... }: with pkgs; [
  # dev
  vim
  wget
  neovim
  git
  gh
  jdk21
  python313
  python313Packages.pip
  nodejs_22
  curl
  htop
  eslint
  zoxide
  fzf
  bat
  starship
  ripgrep
  stow
  zsh
  vscode
  postman
  zulu8
  fd
  docker
  docker-compose
  
  # apps
  xclip
  fastfetch
  _1password-gui
  _1password-cli
  spotify
  slack
  obsidian
  swww
  networkmanagerapplet
  kdePackages.kcalc
  kdePackages.kcharselect
  kdePackages.kcolorchooser # A small utility to select a color
  kdePackages.kolourpaint # Easy-to-use paint program
  kdePackages.ksystemlog # KDE SystemLog Application
  kdePackages.sddm-kcm # Configuration module for SDDM
  kdiff3 # Compares and merges 2 or 3 files or directories
  kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
  kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
  hardinfo2 # System information and benchmarks for Linux systems
  haruna # Open source video player built with Qt/QML and libmpv
  wayland-utils # Wayland utilities
  wl-clipboard # Command-line copy/paste utilities for Wayland
  
  # lsp servers
  typescript-language-server
  nodePackages.typescript
  vscode-langservers-extracted
  tailwindcss-language-server
  clang-tools
  python313Packages.python-lsp-server
  nodePackages.bash-language-server
  sqls
  omnisharp-roslyn
  jdt-language-server
  black
  shfmt
  nodePackages.prettier
  nodePackages.eslint
  tree-sitter
]
