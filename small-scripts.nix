{ pkgs, ... }:

let
  blurlock = pkgs.writeShellScriptBin "blurlock" ''
    # take screenshot
    import -window root /tmp/screenshot.png

    # blur it
    convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
    rm /tmp/screenshot.png

    # lock the screen
    i3lock -i /tmp/screenshotblur.png

    # prevent race with suspend
    sleep 1

    exit 0
  '';
  keylayout = pkgs.writeShellScriptBin "keylayout" ''
    if setxkbmap -query | grep -q variant; then
      setxkbmap us
    else
      setxkbmap us -variant colemak
    fi
  '';
  # Get monitors with xrandr --listmonitors;
  #external-monitor="HDMI-0";
  #internal-monitor="eDP-1-1";
  external-monitor="HDMI-1";
  internal-monitor="eDP-1";
  config-monitor = pkgs.writeShellScriptBin "config-monitor" ''
    # if we don't have a file, start at zero
    if [ ! -f "/tmp/monitor_mode.dat" ] ; then
      monitor_mode="INTERNAL"

    # otherwise read the value from the file
    else
      monitor_mode=`cat /tmp/monitor_mode.dat`
    fi

    if xrandr | grep -q "${external-monitor} connected"; then
      if [ $monitor_mode = "BOTH" ]; then
        monitor_mode="EXTERNAL"
        xrandr --output ${internal-monitor} --off --output ${external-monitor} --auto
      elif [ $monitor_mode = "EXTERNAL" ]; then
         monitor_mode="INTERNAL"
         xrandr --output ${internal-monitor} --auto --output ${external-monitor} --off
      elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="CLONES"
        xrandr --output ${internal-monitor} --auto --output ${external-monitor} --auto --same-as ${internal-monitor}
      else
        monitor_mode="BOTH"
        xrandr --output ${internal-monitor} --primary --auto --output ${external-monitor} --auto --right-of ${internal-monitor}
      fi
      notify-send "Monitor mode: $monitor_mode"
      echo "$monitor_mode" > /tmp/monitor_mode.dat
    else
      notify-send "No external monitor"
      monitor_mode="INTERNAL"
      xrandr --output ${internal-monitor} --auto --output ${external-monitor} --off
      echo "$monitor_mode" > /tmp/monitor_mode.dat
    fi
  '';
  toggle-virtual-monitor = pkgs.writeShellScriptBin "toggle-virtual-monitor" ''
    SERVICE="intel-virtual-o"
    if pgrep -x "$SERVICE" >/dev/null; then
      notify-send 'Killing Virtual Output'
      killall -9 $SERVICE
    else
      notify-send 'Enabling Virtual Output'
      intel-virtual-output
    fi
  '';
in
{
  environment.systemPackages = [
    pkgs.imagemagick
    pkgs.i3lock
    blurlock
    keylayout
    config-monitor
    toggle-virtual-monitor
    pkgs.xorg.xf86videointel
    pkgs.killall
  ];
}
