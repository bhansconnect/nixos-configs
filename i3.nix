{ i3status }:

let
  mod = "Mod4";
  modeSystem = "(l)ock, (e)xit, (s)uspend, (h)ibernate, (r)eboot, (Shift+s)hutdown";
in {
  enable = true;
  config = {
    modifier = "${mod}";
    workspaceAutoBackAndForth = true;
    focus.followMouse = false;
    window = {
      titlebar = false;
      hideEdgeBorders = "none";
      border = 1;
    };
    colors = {
      background = "#2b2c2b";
      focused = {
        border      = "#556064";
        background  = "#556064";
        text        = "#80fff9";
        indicator   = "#fdf6e3";
        childBorder = "#556064";
      };
      focusedInactive = {
        border      = "#2f3d44";
        background  = "#2f3d44";
        text        = "#1abc9c";
        indicator   = "#454948";
        childBorder = "#2f3d44";
      };
      unfocused = {
        border      = "#2f3d44";
        background  = "#2f3d44";
        text        = "#1abc9c";
        indicator   = "#454948";
        childBorder = "#2f3d44";
      };
      urgent = {
        border      = "#cb4b16";
        background  = "#fdf6e3";
        text        = "#1abc9c";
        indicator   = "#268bd2";
        childBorder = "#fdf6e3";
      };
      placeholder = {
        border      = "#000000";
        background  = "#0c0c0c";
        text        = "#ffffff";
        indicator   = "#000000";
        childBorder = "#0c0c0c";
      };
    };
    startup = [
      {command = "pa-applet"; notification = false;} 
      #{command = "fctx -d"; notification = false;} 
      #{command = "nm-applet"; notification = false;} 
      {command = "blueman-applet"; notification = false;} 
      {command = "xfce4-power-manager"; notification = false;} 
      {command = "caffeine"; notification = false;} 
      {command = "xautolock -time 10 -locker blurlock"; notification = false;} 
      {command = "i3-sensible-terminal --title dropdown --class dropdown,dropdown -e tmux"; notification = false;} 
      {command = "i3-sensible-terminal --title math --class math,math -e python3 -q"; notification = false;} 
    ];
    keybindings = {
      # Start Applications
      "${mod}+Return" = "exec i3-sensible-terminal";
      "${mod}+Ctrl+m" = "exec pavucontrol";
      "${mod}+a" = "exec google-chrome-stable";
      #"${mod}+a" = "exec chromium";
      #"${mod}+a" = "exec firefox";
      "${mod}+r" = "exec i3-sensible-terminal -e 'code'";
      "${mod}+s" = "exec i3-sensible-terminal -e 'htop'";
      "${mod}+F2" = "exec pcmanfm";

      # Launchers
      "${mod}+d" = "exec --no-startup-id dmenu_run";
      #"${mod}+d" = "exec --no-startup-id dmenu_recency";
      #"${mod}+z" = "exec --no-startup-id dmenu-frecency";

      # Keyboard Layout Swapping
      "${mod}+x" = "exec --no-startup-id keylayout";

      # Monitor Control
      "${mod}+Shift+m" = "exec --no-startup-id config-monitor";
      "${mod}+k" = "exec --no-startup-id toggle-virtual-monitor";

      # Murder
      "${mod}+Shift+q" = "kill";
      "${mod}+Ctrl+x --release" = "exec --no-startup-id xkill";

      # Screenshots
      #"Print" = "exec --no-startup-id i3-scrot";
      #"${mod}+Print --release" = "exec --no-startup-id i3-scrot -w";
      #"${mod}+Shift+Print --release" = "exec --no-startup-id i3-scrot -s";

      # Keyboard Middle Click
      "${mod}+Ctrl+l" = "exec xdotool mouseup 3";
      "${mod}+Ctrl+k" = "exec xdotool mousedown 3";

      # Focus
      "${mod}+n" = "focus left";
      "${mod}+e" = "focus down";
      "${mod}+i" = "focus up";
      "${mod}+o" = "focus right";

      "${mod}+Left" = "focus left";
      "${mod}+Down" = "focus down";
      "${mod}+Up" = "focus up";
      "${mod}+Right" = "focus right";

      # Movement
      "${mod}+Shift+n" = "move left";
      "${mod}+Shift+e" = "move down";
      "${mod}+Shift+i" = "move up";
      "${mod}+Shift+o" = "move right";

      "${mod}+Shift+Left" = "move left";
      "${mod}+Shift+Down" = "move down";
      "${mod}+Shift+Up" = "move up";
      "${mod}+Shift+Right" = "move right";

      # Resize
      "${mod}+l" = "resize shrink width  5 px or 5 ppt";
      "${mod}+u" = "resize grow   height 5 px or 5 ppt";
      "${mod}+y" = "resize shrink height 5 px or 5 ppt";
      "${mod}+semicolon" = "resize grow   width  5 px or 5 ppt";

      # Workspace Control
      "${mod}+b" = "workspace back_and_forth";
      "${mod}+Shift+b" = "move container to workspace back_and_forth; workspace back_and_forth";
      "${mod}+Ctrl+Right" = "workspace next";
      "${mod}+Ctrl+Left" = "workspace prev";
      "${mod}+m" = "move workspace to output left";

      "${mod}+1" = "workspace number 1";
      "${mod}+2" = "workspace number 2";
      "${mod}+3" = "workspace number 3";
      "${mod}+4" = "workspace number 4";
      "${mod}+5" = "workspace number 5";
      "${mod}+6" = "workspace number 6";
      "${mod}+7" = "workspace number 7";
      "${mod}+8" = "workspace number 8";

      "${mod}+Ctrl+1" = "move container to workspace number 1";
      "${mod}+Ctrl+2" = "move container to workspace number 2";
      "${mod}+Ctrl+3" = "move container to workspace number 3";
      "${mod}+Ctrl+4" = "move container to workspace number 4";
      "${mod}+Ctrl+5" = "move container to workspace number 5";
      "${mod}+Ctrl+6" = "move container to workspace number 6";
      "${mod}+Ctrl+7" = "move container to workspace number 7";
      "${mod}+Ctrl+8" = "move container to workspace number 8";

      "${mod}+Shift+1" = "move container to workspace number 1; workspace number 1";
      "${mod}+Shift+2" = "move container to workspace number 2; workspace number 2";
      "${mod}+Shift+3" = "move container to workspace number 3; workspace number 3";
      "${mod}+Shift+4" = "move container to workspace number 4; workspace number 4";
      "${mod}+Shift+5" = "move container to workspace number 5; workspace number 5";
      "${mod}+Shift+6" = "move container to workspace number 6; workspace number 6";
      "${mod}+Shift+7" = "move container to workspace number 7; workspace number 7";
      "${mod}+Shift+8" = "move container to workspace number 8; workspace number 8";

      # Split Control
      "${mod}+h" = "split h";
      "${mod}+v" = "split v";
      #"${mod}+h" = "split h;exec notify-send 'tile-horizontally'";
      #"${mod}+v" = "split v;exec notify-send 'tile-vertically'";
      #"${mod}+q" = "split toggle";
      "${mod}+q" = "layout toggle split";

      # Misc Control
      "${mod}+t" = "fullscreen toggle";
      "${mod}+Shift+space" = "floating toggle";
      "${mod}+space" = "focus mode_toggle";
      "${mod}+Shift+h" = "bar mode toggle";
      "${mod}+Shift+minus" = "move scratchpad";
      "${mod}+minus" = "scratchpad show";

      # Dropdown Control
      "${mod}+f" = "[instance = \"dropdown\"] scratchpad show";
      "${mod}+w" = "[instance = \"math\"] scratchpad show";

      # i3 Control
      "${mod}+Shift+c" = "reload";
      "${mod}+Shift+r" = "restart";
      "${mod}+9" = "exec --no-startup-id blurlock";
      "${mod}+0" = "mode \"${modeSystem}\"";
    };
    modes = {
      "${modeSystem}" = {
        "l" = "exec --no-startup-id blurlock, mode default";
        "s" = "exec --no-startup-id \"blurlock; systemctl suspend\", mode default";
        "e" = "exec --no-startup-id i3-msg exit, mode default";
        "h" = "exec --no-startup-id \"blurlock; systemctl hibernate\", mode default";
        "r" = "exec --no-startup-id systemctl reboot, mode default";
        "Shift+s" = "exec --no-startup-id systemctl poweroff, mode default";
        "Return" = "mode default";
        "Escape" = "mode default";
      };
    };
    bars = [{
      mode = "dock";
      hiddenState = "hide";
      position = "bottom";
      workspaceButtons = true;
      workspaceNumbers = true;
      statusCommand = "${i3status}/bin/i3status";
      fonts = [ "URQGothic-Book 11" "FiraCode 11" "Monospace 10" ];
      trayOutput = "primary";
      colors = {
        background = "#222d31";
        statusline = "#f9faf9";
        separator = "#454947";
        focusedWorkspace = {
          border = "#f9faf9";
          background = "#16a085";
          text = "#292f34";
        };
        activeWorkspace = {
          border = "#595b5b";
          background = "#353836";
          text = "#fdf6e3";
        };
        inactiveWorkspace = {
          border = "#595b5b";
          background = "#222d31";
          text = "#eee8d5";
        };
        urgentWorkspace = {
          border = "#16a085";
          background = "#fdf6e3";
          text = "#e5201d";
        };
        bindingMode = {
          border = "#16a085";
          background = "#222d31";
          text = "#f9faf9";
        };
      };
    }];
  };
  extraConfig = ''
    # dropdown terminal and python
    for_window [class = "dropdown"] floating enable
    for_window [class = "dropdown"] resize set 1920 400
    for_window [class = "dropdown"] move position 0 0
    for_window [class = "dropdown"] move scratchpad

    for_window [class = "math"] floating enable
    for_window [class = "math"] resize set 1920 400
    for_window [class = "math"] move position 0 0
    for_window [class = "math"] move scratchpad
  '';
}
