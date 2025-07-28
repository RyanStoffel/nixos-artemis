{ pkgs, inputs, ... }: with pkgs; [
  # dev tools
  vim
  neovim
  git
  gh
  curl
  wget
  htop
  zoxide
  fzf
  bat
  starship
  ripgrep
  stow
  zsh
  fd
  docker
  docker-compose
  
  # programming languages & runtimes
  jdk21
  python313
  python313Packages.pip
  nodejs_22
  zulu8
  
  # code editors & IDEs
  vscode
  zed-editor
  
  # development tools
  postman
  
  # browsers
  firefox
  firefox-devedition
  google-chrome
  inputs.zen-browser.packages.${pkgs.system}.default
  
  # terminals
  kitty
  alacritty
  
  # communication
  slack
  discord
  
  # productivity
  obsidian
  _1password-gui
  _1password-cli
  nautilus
  
  # media
  spotify
  vlc
  
  # gaming
  steam
  
  # mail client
  thunderbird
  
  # system utilities
  xclip
  wl-clipboard
  fastfetch
  networkmanagerapplet
  pavucontrol
  blueman
  
  # wayland/hyprland specific
  swww
  wofi
  waybar
  dunst
  
  # KDE utilities (since you liked the plasma taskbar style)
  kdePackages.kcalc
  kdePackages.kcharselect
  kdePackages.kcolorchooser
  kdePackages.kolourpaint
  kdePackages.ksystemlog
  kdePackages.sddm-kcm
  kdiff3
  kdePackages.isoimagewriter
  kdePackages.partitionmanager
  
  # system info & monitoring
  hardinfo2
  haruna 
  
  # wayland utilities
  wayland-utils
  
  # language servers & formatters
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
  eslint
  tree-sitter
]
