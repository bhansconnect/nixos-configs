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
in
{
  environment.systemPackages = [
    pkgs.imagemagick
    pkgs.i3lock
    blurlock
  ];
}
