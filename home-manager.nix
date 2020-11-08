{ lib, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    name = "home-manager";
    url = "https://github.com/rycee/home-manager.git";
    ref = "release-20.09";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.bren077s = {
    programs.home-manager.enable = true;

    programs.git = {
      enable = true;
      userName = "bhansconnect";
      userEmail = "brendan.hansknecht@gmail.com";
    };

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNixDirenvIntegration = true;
    };

    programs.zsh.enable = true;
    programs.zsh.enableAutosuggestions = true;
    programs.zsh.oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "ssh-agent" "colored-man-pages" "colorize"
        "command-not-found" "compleat" "cp" "encode64" "extract" "rsync"
        "web-search" "emoji-clock" "rand-quote"
      ];
      theme = "robbyrussell";
    };

    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 11;
      };
    };

    home.keyboard = null;
    xsession = {
      enable = true;
      windowManager.i3 =
      let
        mod = "Mod4";
        modeSystem = "(l)ock, (e)xit, (s)uspend, (h)ibernate, (r)eboot, (Shift+s)hutdown";
      in {
        enable = true;
        config = {
          modifier = "${mod}";
          workspaceAutoBackAndForth = true;
          startup = [
            {command = "pa-applet"; notification = false;} 
            #{command = "fctx -d"; notification = false;} 
            #{command = "nm-applet"; notification = false;} 
            {command = "blueman-applet"; notification = false;} 
            {command = "xfce4-power-manager"; notification = false;} 
            {command = "caffeine"; notification = false;} 
            #{command = "xautolock -time 10 -locker blurlock"; notification = false;} 
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
            #"${mod}+x" = "exec --no-startup-id /home/bren077s/keylayout.sh";

            # Monitor Control
            #"$mod+Shift+m" = "exec --no-startup-id /home/bren077s/configmonitor.sh";
            #"$mod+k" = "exec --no-startup-id /home/bren077s/togglemonitor.sh";

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
            "${mod}Shift+b" = "move container to workspace back_and_forth; workspace back_and_forth";
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
            #"${mod}+v" = "split v;exec notify-send 'tile-horizontally'";
            #"${mod}+q" = "split toggle";
            "${mod}+q" = "layout toggle split";

            # Misc Control
            "${mod}+t" = "fullscreen toggle";
            "${mod}+Shift+space" = "floating toggle";
            "${mod}+space" = "mode_toggle";
            "${mod}+Shift+h" = "bar mode toggle";
            "${mod}+Shift+minus" = "move scratchpad";
            "${mod}+minus" = "scratchpad show";

            # i3 Control
            "${mod}+Shift+c" = "reload";
            "${mod}+Shift+r" = "restart";
            #"${mod}+9" = "exec --no-startup-id blurlock";
            "${mod}+0" = "mode \"${modeSystem}\"";
          };
          modes = {
            "${modeSystem}" = {
              "l" = "exec --no-statup-id blurlock";
              "s" = "exec --no-statup-id systemctl suspend";
              "e" = "exec --no-statup-id i3-msg exit";
              "h" = "exec --no-statup-id systemctl hibernate";
              "r" = "exec --no-statup-id systemctl reboot";
              "Shift+s" = "exec --no-statup-id systemctl poweroff";
              "Return" = "mode default";
              "Escape" = "mode default";
            };
          };
        };
      };
    };
    
    home.packages = with pkgs; [
      i3lock i3status dmenu
    ];

    systemd.user.services.mpris-proxy = {
      Unit.Description = "Mpris proxy";
      Unit.After = [ "network.target" "sound.target" ];
      Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
      Install.WantedBy = [ "default.target" ];
    };
  };
}
