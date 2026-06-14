{ stdenv, lib, python3, python3Packages, alsa-utils, fetchFromGitHub, makeWrapper }:

let
  pname = "blueyeti-linux";
  version = "2026-06-14";
in
stdenv.mkDerivation rec {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "JackRozells";
    repo = pname;
    rev = "cac4b3f28fbf3425b79abb57bf2935f4d68f86a5";
    sha256 = "sha256-b2f3BBeEQMmarNPz4iEvuRkYiUIPcHJNu2qpJloq0iw=";
  };

  buildInputs = [ makeWrapper ];

  propagatedBuildInputs = [
    python3
    python3Packages.tkinter
    alsa-utils
  ];

  doCheck = false;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib/python3.10/site-packages
    mkdir -p $out/lib/udev/rules.d
    mkdir -p $out/lib/systemd/user
    mkdir -p $out/share/applications

    # Install Python package
    cp -r $src/blueyeti $out/lib/python3.10/site-packages/

    # Install CLI and GUI scripts
    makeWrapper "${python3}/bin/python3" "$out/bin/blueyeti-cli" \
      --set PYTHONPATH "$out/lib/python3.10/site-packages:$PYTHONPATH" \
      --add-flags "-m blueyeti.cli"

    makeWrapper "${python3}/bin/python3" "$out/bin/blueyeti-gui" \
      --set PYTHONPATH "$out/lib/python3.10/site-packages:$PYTHONPATH" \
      --add-flags "-m blueyeti.gui"

    # Install udev rules
    cp $src/70-blueyeti.rules $out/lib/udev/rules.d/

    # Install systemd service
    cp $src/blueyeti-autoconfig.service $out/lib/systemd/user/

    # Install desktop file
    cat > $out/share/applications/blueyeti.desktop <<EOF
[Desktop Entry]
Name=Blue Yeti Control
Comment=Control your Blue Yeti microphone
Exec=$out/bin/blueyeti-gui
Icon=audio-input-microphone
Terminal=false
Type=Application
Categories=AudioVideo;Audio;Settings;
Keywords=microphone;yeti;blue;audio;sidetone;
EOF
  '';

  meta = with lib; {
    description = "Native control application for Blue Yeti USB microphone on Linux";
    homepage = "https://github.com/JackRozells/blueyeti-linux";
    license = licenses.mit;
    maintainer = "you@example.com";
    platforms = [ "x86_64-linux" ];
  };
}
