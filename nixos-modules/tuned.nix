{
  services.tuned = {
    enable = true;
    settings = {
      dynamic_tuning = true;
      update_interval = 20;
    };
  };
}
