{
  # Audio configuration
  services.pulseaudio.enable = false;
  security.rtkit.enable = true; # Realtime kit for pipewire
  services.pipewire = {
    enable = true; # Modern audio server
    alsa.enable = true; # ALSA support
    alsa.support32Bit = true; # 32-bit ALSA support
    pulse.enable = true; # PulseAudio compatibility
    jack.enable = true; # JACK audio support
    wireplumber.enable = true; # Session manager
  };
}
