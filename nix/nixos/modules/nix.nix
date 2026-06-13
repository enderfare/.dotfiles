{
  # Nix package manager configuration
  nix = {
    # Allow root and beta user to manage nix store
    extraOptions = "trusted-users = root beta ";

    # Check configuration for errors during build
    checkConfig = true;

    # Automatically optimize store to reduce disk usage
    optimise.automatic = true;

    # Automatic garbage collection settings
    gc = {
      automatic = true; # Enable automatic garbage collection
      dates = "weekly"; # Run weekly
      options = "--delete-older-than 3d"; # Remove packages older than 3 days
    };

    # Nix settings
    settings = {
      experimental-features = "nix-command flakes"; # Enable flakes and new CLI
      auto-optimise-store = true; # Automatically deduplicate and optimize store
    };
  };

}
