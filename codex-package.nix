{
  lib,
  pkgs,
}:
let
  version = "0.144.1";
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
    hash = "sha256-RXqbOetC0fb78F2vr3EielM245UBg3A96Ypmpaz+uBQ=";
    mainProgram = "codex";
  };

  appServer = fetchCodexPackage {
    name = "codex-app-server-package";
    hash = "sha256-v5S+2d6ye0kabdWxUhWEBXfdJ80Fxn3yYyHtjQzG7BM=";
    mainProgram = "codex-app-server";
  };
}
