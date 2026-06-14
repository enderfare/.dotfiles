{ pkgs, ... }:
{
  services = {
    blueyeti-autoconfig = {
    description = "Blue Yeti Auto-Configure";
    wantedBy = [ "default.target" ];
    after = [ "sound.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.blueyeti-linux}/bin/blueyeti-cli preset silent_monitor";
    };
  };
  };
}
