{ pkgs, ... }:
{
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      beta = {
        isNormalUser = true;
        description = "beta";
        extraGroups = [
          "networkmanager"
          "wheel"
          "input"
          "aria2"
          "docker"
        ];
        packages = with pkgs; [
          kdePackages.kate
          #  thunderbird
        ];
        shell = pkgs.zsh;
      };
    };
    groups = {
      docker = {
        name = "docker";
        gid = 1001;
      };
    };
  };
}
