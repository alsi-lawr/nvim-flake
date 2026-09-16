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

  desktopVersion = "26.903.61454";

  desktop = pkgs.stdenv.mkDerivation {
    pname = "chatgpt";
    version = desktopVersion;

    src = pkgs.fetchurl {
      url = "https://persistent.oaistatic.com/codex-app-prod/linux/deb/pool/main/c/chatgpt/chatgpt_${desktopVersion}_amd64.deb";
      hash = "sha256-LKp98xTON+kEg1nY5qSnjiRXSjtU1r9RDxd1S2bdp3U=";
    };

    nativeBuildInputs = with pkgs; [
      dpkg
      autoPatchelfHook
      wrapGAppsHook3
    ];

    buildInputs = with pkgs; [
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk3
      libGL
      libdrm
      libgbm
      libnotify
      libpulseaudio
      libsecret
      libusb1
      libxkbcommon
      nspr
      nss
      pango
      pipewire
      stdenv.cc.cc.lib
      systemd
      wayland

      xorg.libX11
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXrandr
      xorg.libxcb
    ];

    autoPatchelfIgnoreMissingDeps = [
      "libc++_shared.so"
      "libc.musl-x86_64.so.1"
      "liblog.so"

      # Optional Qt integration shims.
      "libQt5Core.so.5"
      "libQt5Gui.so.5"
      "libQt5Widgets.so.5"
      "libQt6Core.so.6"
      "libQt6Gui.so.6"
      "libQt6Widgets.so.6"
    ];

    unpackPhase = ''
      dpkg-deb -x "$src" .
    '';

    installPhase = ''
      mkdir -p "$out"
      cp -r usr/* "$out/"
    '';

    meta = {
      description = "ChatGPT desktop application";
      homepage = "https://chatgpt.com/";
      license = lib.licenses.unfree;
      mainProgram = "chatgpt";
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

  inherit desktop;
}
