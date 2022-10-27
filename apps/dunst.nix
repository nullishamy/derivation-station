# Dunst settings

{ config, lib, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {

      global = {
        font = "FantasqueSansMono Nerd Font Mono";

        # Allow markup in messages, bold italic etc
        markup = "full";
        plaintext = "no";

        # The format of the message.  Possible variables are:
        #   %a  appname
        #   %s  summary
        #   %b  body
        #   %i  iconname (including its path)
        #   %I  iconname (without its path)
        #   %p  progress value if set ([  0%] to [100%]) or nothing
        # Markup is allowed
        format = "<b>%s</b>\n%b";

        # Sort by severity
        sort = "yes";

        # Indicate if there's some amount of hidden messages
        indicate_hidden = "yes";

        # Align text in the center
        alignment = "center";
        vertical_alignment = "center";

        # The frequency at which text can scroll in the notification, we disable it.
        # We use word_wrap instead.
        bounce_freq = 0;
        word_wrap = "yes";

        # Hide duplicates and stack them instead
        # stack_duplicates = "yes";
        # hide_duplicate_count = "yes";

        # Respect newlines (\n)
        ignore_newline = "no";

        # Disable icons
        icon_position = "off";

        # The geometry of the window:
        #   [{width}]x{height}[+/-{x}+/-{y}]

        # The geometry of the message window.
        # The height is measured in number of notifications everything else
        # in pixels. If the width is omitted but the height is given
        # ("-geometry x2"), the message window expands over the whole screen
        # (dmenu-like).  

        # If width is 0, the window expands to the longest
        # message displayed. A positive x is measured from the left, a
        # negative from the right side of the screen. Y is measured from
        # the top and down respectevly.

        # The width can be negative.  In this case the actual width is the
        # screen width minus the width defined in within the geometry option.
        # geometry = "250x50-40+40"
        geometry = "300x30-5+60";

        # Shrink window if it's smaller than the width.
        shrink = "no";

        # Don't remove messages if the user is idle (no mouse or keyboard input)
        # for longer than idle_threshold seconds.
        # Set to 0 to disable.
        idle_threshold = 0;

        # Which monitor should the notifications be displayed on.
        monitor = 0;

        # Display indicators for URLs (U) and actions (A).
        show_indicators = "no";

        # The height of a single line.  If the height is smaller than the
        # font height, it will get raised to the font height.
        # This adds empty space above and under the text.
        line_height = 3;

        # Height of whole notification    
        notification_height = 0;

        # Draw a line of "separatpr_height" pixel height between two
        # notifications.
        # Set to 0 to disable.
        separator_height = 2;

        # Padding between text and separator.
        padding = 8;

        # Horizontal padding.
        horizontal_padding = 8;

        # Define a color for the separator.
        # possible values are:
        #  * auto: dunst tries to find a color fitting to the background;
        #  * foreground: use the same color as the foreground;
        #  * frame: use the same color as the frame;
        #  * anything else will be interpreted as a X color.
        separator_color = "frame";

        # Print a notification on startup.
        # This is mainly for error detection, since dbus (re-)starts dunst
        # automatically after a crash.
        startup_notification = true;

        # Browser for opening urls in context menu.
        browser = "${pkgs.chromium} - new-tab";

        # Mouse
        # Left click
        mouse_left_click = "do_action";
        # Middle click
        mouse_middle_click = "close_current";
        # Right click
        mouse_right_click = "close_current";

        # History length
        history_length = 20;
      };

      # Appearance / theme
      global = {
        frame_width = 2;
        frame_color = "#504945";

        # Corner radius of dunst
        corner_radius = 5;
      };

      urgency_low = {
        foreground = "#928374";
        background = "#1D2021";
        "#background" = "#1D2021";
        timeout = 4;
      };

      urgency_normal = {
        foreground = "#8EC07C";
        background = "#1D2021";
        "#background" = "#1D2021";
        timeout = 6;
      };

      urgency_critical = {
        foreground = "#FB4934";
        background = "#1D2021";
        "#background" = "#1D2021";
        timeout = 8;
      };

      # Shortcuts
      shortcuts = {
        # Close notification.
        close = "ctrl+space";

        # Close all notifications.
        close_all = "ctrl+shift+space";

        # Redisplay last message(s).
        history = "ctrl+grave";

        # Context menu.
        context = "ctrl+shift+period";
      };
    };
  };
}
