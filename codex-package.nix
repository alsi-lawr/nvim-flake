{
  lib,
  pkgs,
}:
let
  version = "0.153.3";
  target = "x86_64-unknown-linux-musl";
  fetchCodexPackage =
    {
      hash,
      mainProgram,
      name,
    }:
    pkgs.fetchzip {
      inherit name hash;
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/${name}-${target}.tar.gz";
      stripRoot = false;
      meta = {
        description = "Lightweight coding agent that runs in your terminal";
        homepage = "https://github.com/openai/codex";
        license = lib.licenses.asl20;
        inherit mainProgram;
        platforms = [ "x86_64-linux" ];
        sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
      };
    };
in
{
  cli = fetchCodexPackage {
    name = "codex-package";
    hash = "sha256-2H2zwXMUu0qkq7j6P2qk4KEE1VGyscOQrTuO2liTGHs=";
    mainProgram = "codex";
  };

  appServer = fetchCodexPackage {
    name = "codex-app-server-package";
    hash = "sha256-Ch3VYK54vw9cVUBUTbPrsFJQ+vW2FkGW4H6uCZwAoFw=";
    mainProgram = "codex-app-server";
  };
}
