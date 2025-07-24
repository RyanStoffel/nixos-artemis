{ pkgs, ... }:

let
  sfdx-fhs = pkgs.buildFHSEnv {
    name = "sfdx-fhs";
    
    targetPkgs = pkgs: with pkgs; [
      nodejs_22
      python3
      git
      curl
      wget
      gnupg
      cacert
      openssl
      zlib
      glibc
      gcc-unwrapped
      binutils
      coreutils
      findutils
      gnugrep
      gnused
      gnutar
      gzip
      which
      bash
      procps
      util-linux
    ];
    
    multiPkgs = pkgs: with pkgs; [
      zlib
      openssl
    ];
    
    profile = ''
      export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
      export CURL_CA_BUNDLE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
      export NODE_EXTRA_CA_CERTS=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
      
      export NPM_CONFIG_PREFIX="$HOME/.npm-global"
      export PATH="$HOME/.npm-global/bin:$PATH"
      
    '';
    
    runScript = "bash";
  };

  sfdx-wrapper = pkgs.writeShellScriptBin "sfdx-wrapper" ''
    if ${sfdx-fhs}/bin/sfdx-fhs -c "command -v sfdx >/dev/null 2>&1"; then
      ${sfdx-fhs}/bin/sfdx-fhs -c "sfdx $*"
    else
      exit 1
    fi
  '';

  sf-wrapper = pkgs.writeShellScriptBin "sf-wrapper" ''
    if ${sfdx-fhs}/bin/sfdx-fhs -c "command -v sf >/dev/null 2>&1"; then
      ${sfdx-fhs}/bin/sfdx-fhs -c "sf $*"
    else
      exit 1
    fi
  '';

  salesforce-cli = pkgs.writeShellScriptBin "salesforce-cli" ''
    echo "Salesforce CLI Commands:"
    echo "  sf-wrapper [command]    - Use modern sf CLI"
    echo "  sfdx-wrapper [command]  - Use legacy sfdx CLI"
    echo "  sfdx-fhs               - Enter FHS environment directly"
    echo ""
    echo "Examples:"
    echo "  sf-wrapper org list"
    echo "  sfdx-wrapper force:org:list"
  '';

in
{
  inherit sfdx-fhs sfdx-wrapper sf-wrapper salesforce-cli;
}
