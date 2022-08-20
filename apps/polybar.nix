# Polybar settings

{ config, lib, pkgs, ...}:

{
  services.polybar = {
    enable = true;
    script = "polybar -r top &";
    config = {
      colors = {
        background = "#282828";
        background-alt = "#504945";
        foreground = "#EBDBB2";
        alert = "#BD2C40";
        underline = "#83A598";
      };

      "bar/top" = {
        width = "100%";
        height = "3%";
        radius = 6;

        background = "\${colors.background}";
        foreground = "\${colors.foreground}";

        line-size = 3;
        line-color = "\${colors.underline}";

        modules-left = "i3";
        modules-right = "memory cpu eth date";

        font-0 = "Hack Nerd Font Mono:size=11;2";

        border-size = "4pt";
        border-color = "#00000000";

        padding-left = 0;
        padding-right = 1;

        module-margin = 1;

        separator = "|";
        separator-foreground = "\${colors.foreground}";

        wm-restack = "generic";
        cursor-click = "pointer";
      };

      "module/i3" = {
        type = "internal/xworkspaces";
        wrapping-scroll = true;

        label-active = "%name%";
        label-active-background = "\${colors.background-alt}";
        label-active-underline= "\${colors.underline}";
        label-active-padding = 1;

        label-occupied = "%name%";
        label-occupied-padding = 1;

        label-urgent = "%name%";
        label-urgent-background = "\${colors.alert}";
        label-urgent-padding = 1;

        label-empty = "%name%";
        label-empty-foreground = "\${colors.background}";
        label-empty-padding = 1;

      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix-foreground = "\${colors.foreground}";
        label = "CPU: %percentage:2%%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix-foreground = "\${colors.foreground}";
        label = "MEM: %percentage_used%%";
      };

      "module/eth" = {
        type = "internal/network"; 
        interface = "enp8s0";
        interval = 3;

        format-connected-prefix-foreground = "\${colors.foreground}";
        label-connected = "ETH: %local_ip%";

        label-disconnected = "ETH: N/A";
      };

      "module/date" = {
        type = "internal/date";
        interval = 5;
        date = "%d %b %Y";
        time = "%H:%M";

        label = "%date% @ %time%";
      };

      "settings" = {
        screenchange-reload = true;
        pseudo-transparency = true;
      };

      "global/wm" = {
        margin-top = 0;
      };
    };
  };
}
