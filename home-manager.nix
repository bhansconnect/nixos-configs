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

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      shellAliases = {
        c = "code .";
        suod = "sudo";
        blaze = "bazel";
        gowatch = "fswatch -r -0 --monitor=poll_monitor $(find . -name \"*.go\") | xargs -0 -n1 -I{}";
        zigwatch = "fswatch -r -0 --monitor=poll_monitor $(find . -name \"*.zig\") | xargs -0 -n1 -I{}";
      };
      sessionVariables = {
        RUST_LOG = "info";
        CC = "clang";
        CXX = "clang++";
        EDITOR = "vim";
      };
    };
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
        scrolling = {
          history = 10000;
          multiplier = 3;
        };
        colors = {
          primary = {
            background = "#282828";
            foreground = "#ebdbb2";
          };
          normal = {
            black   = "#282828";
            red     = "#cc241d";
            green   = "#98971a";
            yellow  = "#d79921";
            blue    = "#458588";
            magenta = "#b16286";
            cyan    = "#689d6a";
            white   = "#a89984";
          };
          bright = {
            black   = "#928374";
            red     = "#fb4934";
            green   = "#b8bb26";
            yellow  = "#fabd2f";
            blue    = "#83a598";
            magenta = "#d3869b";
            cyan    = "#8ec07c";
            white   = "#ebdbb2";
          };
        };
      };
    };

    home.keyboard = null;
    xsession = {
      enable = true;
      windowManager.i3 = import ./i3.nix { i3status = pkgs.i3status; };
    };

    programs.neovim = import ./nvim.nix { vimPlugins = pkgs.vimPlugins; };
    programs.vscode = import ./vscode.nix { vscodium = pkgs.vscodium; vscode-extensions = pkgs.vscode-extensions; };

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
