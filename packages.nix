{ pkgs, ... }: with pkgs; [
  # Existing packages
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
  gnome-session
  xclip
  zsh
  ghostty
  fastfetch
  _1password-gui
  _1password-cli
  spotify
  slack
  obsidian
  vscode
  postman
  zulu8
  swww

  # Language Servers for your Neovim setup
  typescript-language-server      # JavaScript/TypeScript/React/Next.js
  nodePackages.typescript        # TypeScript compiler
  vscode-langservers-extracted    # HTML, CSS, JSON, ESLint language servers
  tailwindcss-language-server     # Tailwind CSS
  clang-tools                     # C/C++ (includes clangd)
  python313Packages.python-lsp-server  # Python LSP
  nodePackages.bash-language-server     # Shell scripts
  sqls                           # SQL language server
  omnisharp-roslyn               # C# language server
  jdt-language-server            # Java language server
  
  # Formatters and Linters
  black                          # Python formatter
  shfmt                          # Shell script formatter  
  nodePackages.prettier         # JS/TS/HTML/CSS formatter
  nodePackages.eslint           # JavaScript linter
  
  # Development tools
  tree-sitter                    # Better syntax highlighting
  fd                             # Better find command
  
  # Docker support (for Salesforce CLI if needed)
  docker
  docker-compose
]
