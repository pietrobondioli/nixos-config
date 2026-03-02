{ ... }: {
  # System-level idle sleep fallback (works even when swayidle/compositor isn't running)
  services.logind.settings.Login = {
    IdleAction = "suspend";
    IdleActionSec = "20min";
  };
}
