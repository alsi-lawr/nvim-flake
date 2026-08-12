{
  lib,
  pkgs,
}:
let
  version = "0.147.0";
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
    hash = "sha256-EfjpvJK6rHX8ylZ5ED8O+isdogj8WONQuPSjRkuPgZU=";
    mainProgram = "codex";
  };

  appServer = fetchCodexPackage {
    name = "codex-app-server-package";
    hash = "sha256-mFaCW0eWxAqDStumABzyJtJ3fBHtY8xKhAl2xQDZ5S8=";
    mainProgram = "codex-app-server";
  };
}
