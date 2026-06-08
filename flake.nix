{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { ... }:
    {
      homeModules.default =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        let
          cfg = config.alsi.nvim;
        in
        {
          options.alsi.nvim.configPath = lib.mkOption {
            type = lib.types.str;
            default = "/root/.nix/.nvim-flake/nvim";
            description = "Path to the editable Neovim config directory.";
          };

          config = {
            programs.neovim = {
              enable = true;
              defaultEditor = true;
              viAlias = true;
              vimAlias = true;
              withRuby = true;
              withPython3 = true;
              sideloadInitLua = true;
            };

            home.file.".config/nvim".source =
              config.lib.file.mkOutOfStoreSymlink cfg.configPath;

            home.packages = with pkgs; [
              xclip
              ripgrep
              fd
              fzf
              gnumake
              pkg-config
              cmake
              ninja
              unzip
              tree-sitter
              neovim-node-client
              python3Packages.pynvim
              codex
              claude-code
            ];
          };
        };
    };
}
