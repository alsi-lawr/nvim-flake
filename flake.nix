{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { ... }: {
    homeManagerModules.default = { config, pkgs, ... }: {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };

      xdg.configFile."nvim".source = ./nvim;

      home.packages = with pkgs; [
        xclip
        ripgrep
        fd
        lua-language-server
        fzf
        gcc
        gnumake
        pkg-config
        cmake
        ninja
        unzip
        tree-sitter
        nodePackages_latest.neovim
        python3Packages.pynvim
      ];
    };
  };
}
