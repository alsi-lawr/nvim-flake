{
  lib,
  pkgs,
}:
let
  version = "0.145.0";
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
    hash = "sha256-bfIY2Je2bDgf9syK3otOS7Pd6UXhvahfSa8ASUaXUIk=";
    mainProgram = "codex";
  };

  appServer = fetchCodexPackage {
    name = "codex-app-server-package";
    hash = "sha256-9NqyIWksnk87XqPyDF9Oa9Mnh/BIXqmPxKXxbP5HZMw=";
    mainProgram = "codex-app-server";
  };
}
