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
