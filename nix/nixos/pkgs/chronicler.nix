# chronicler.nix
{ lib, stdenv, fetchurl, dpkg, autoPatchelfHook, makeWrapper
, wrapGAppsHook3                          # <-- new
, glib, gtk3, webkitgtk_4_1, libsoup_3, openssl, zlib
, pango, cairo, gdk-pixbuf, atk, libappindicator-gtk3
, libx11, libxcomposite, libxdamage, libxext, libxfixes
, libxrender, libxrandr, libxcb
, libxkbcommon, libdrm, mesa
, gsettings-desktop-schemas              # <-- new
, fontconfig, liberation_ttf             # <-- new
}:

stdenv.mkDerivation rec {
  pname = "chronicler";
  version = "0.54.0";                   
  src = fetchurl {
    url = "https://github.com/mak-kirkland/chronicler/releases/download/v${version}-alpha/Chronicler_${version}_amd64.deb";
    hash = "sha256-nG/ux2Ss2cFlytiuMANbN+8tetbnXqqMm1LCOfSEXJg=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
    wrapGAppsHook3          # provides the GTK runtime wrapping
  ];

  buildInputs = [
    glib gtk3 webkitgtk_4_1 libsoup_3 openssl zlib
    pango cairo gdk-pixbuf atk libappindicator-gtk3
    libx11 libxcomposite libxdamage libxext libxfixes
    libxrender libxrandr libxcb libxkbcommon libdrm mesa
    gsettings-desktop-schemas
    fontconfig liberation_ttf
  ];

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x $src .
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share $out/lib
    cp -r usr/bin/*       $out/bin/
    cp -r usr/share/*     $out/share/ 2>/dev/null || true
    cp -r usr/lib/*       $out/lib/   2>/dev/null || true

    # Fix .desktop file: set Exec to the Nix store path
    for f in $out/share/applications/*.desktop; do
      if [ -f "$f" ]; then
        sed -i "s|^Exec=.*|Exec=$out/bin/chronicler|" "$f"
      fi
    done

    runHook postInstall
  '';

  # autoPatchelfHook runs automatically; wrapGAppsHook3 will
  # wrap the binary with the right environment variables.

  meta = with lib; {
    description = "Chronicler – free, offline worldbuilding tool and local wiki";
    homepage    = "https://github.com/mak-kirkland/chronicler";
    license     = licenses.free;
    platforms   = [ "x86_64-linux" ];
    mainProgram = "chronicler";
  };
}
