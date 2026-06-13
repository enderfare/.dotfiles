{ pkgs, ... }:
{
  # Import hardware-specific configuration and custom modules
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules/bundle.nix
  ];

  # Network configuration
  networking.hostName = "nixos"; # System hostname

  # Keyboard configuration
  console.keyMap = "es"; # Console keyboard layout

  # System state version (should not be changed after initial install)
  system.stateVersion = "25.05";
}
