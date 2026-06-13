{ pkgs, ... }:
{

  nixpkgs = {
    config = {
      allowUnfree = true;

      permittedInsecurePackages = [
        "electron-39.8.10"
      ];
    };
    overlays = [
      (final: prev: {
        lombokEclipse =
          with prev.eclipses;
          eclipseWithPlugins {
            eclipse = eclipse-java;
            jvmArgs = [
              "-javaagent:/home/beta/.m2/repository/org/projectlombok/lombok/1.18.38/lombok-1.18.38.jar"
            ];
            plugins = [ ];
          };
      })
    ];
  };

  # ===================== ENABLE JAVA GLOBALLY =====================
  programs.java = {
    enable = true;
    package = pkgs.openjdk25; # OpenJDK 25
  };
  # =================================================================

  environment = {
    systemPackages = with pkgs; [
      # Development Tools
      python3
      git
      gcc
      zig
      zls
      bun
      nixfmt
      nixfmt-tree
      cmake
      nodejs
      pnpm
      sqlc
      dbeaver-bin
      go
      # openjdk                  # <--- REMOVED: now provided globally by programs.java
      jetbrains.idea-oss # will find JDK 21 automatically
      mongodb-compass
      dpkg
      rustdesk
      elixir
      #      nodePackages_22."@angular/cli"

      # Version Control
      lazygit
      #ggc

      # Text Editors & IDEs
      neovim
      vscode
      #eclipses.eclipse-java
      #lombok
      lombokEclipse

      # System Utilities
      direnv
      wget
      tree
      stow
      unrar
      gparted
      docker
      docker-compose
      lazydocker
      protontricks
      btop
      dysk
      easyeffects
      #      fgalaxy

      # Terminal Utilities
      fastfetch
      kitty
      lsd
      bat
      fzf
      ripgrep
      curl
      fd
      oxker
      superfile
      posting
      ani-cli

      # Multimedia
      mpv
      cava
      ffmpeg
      kew

      # Gaming
      wine
      wine64
      winetricks
      winboat
      modrinth-app

      # Web Browsers
      vivaldi

      # Communication
      discord
      vesktop
      telegram-desktop

      # Note Taking
      obsidian
      logseq

      # Download Utilities
      qbittorrent
      yt-dlp
      amule
      tdl

      # Disk Utilities
      caligula

      # Video editors
      davinci-resolve

      # 3D Editor
      blockbench
    ];
  };

  # Fonts
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
  ];
}
