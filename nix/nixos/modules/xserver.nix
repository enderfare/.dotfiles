{
  services = {
    xserver = {
      enable = true;
      #windowManager.herbstluftwm.enable = true;

      # displayManager = {
      #   autoLogin.enable = true;
      #   autoLogin.user = "amper";
      #   lightdm.enable = true;
      # };

      xkb = {
        layout = "es,us";
        variant = "";
      };

      deviceSection = ''Option "TearFree" "True"'';
      #displayManager.gdm.enable = true;
      #desktopManager.gnome.enable = true;
    };
    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      touchpad.accelProfile = "flat";
    };
  };
}
