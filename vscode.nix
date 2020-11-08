{ vscodium, vscode-extensions }:
{
  enable = true;
  package = vscodium;
  extensions = with vscode-extensions; [
    # devoncarew.bazel-code
    ## bungcip.better-toml
    # maxgabriel.brittany
    ms-vscode.cpptools
    # ms-dotnettools.csharp
    # twxs.cmake
    # ms-vscode.cmake-tools
    ## naumovs.color-highlight
    # tcwalther.cpython
    ## elmtooling.elm-ls-vscode
    ## dbaeumer.vscode-eslint
    ## mkxml.vscode-filesize
    ## golang.go
    ## tomphilbin.gruvbox-themes
    # alanz.vscode-hie-server
    # justusadam.language-haskell
    # jcanero.hoogle-vscode
    ## esbeng.prettier-vscode
    ms-python.python
    # jaredly.reason-vscode
    ## rust-lang.rust
    # ivan-bocharov.stan-vscode
    # mshr-h.veriloghdl
    vscodevim.vim
    # mjmcloug.vscode-elixir
    ## 13xforever.language-x86-64-assembly
    ## tiehuis.zig
  ];
  userSettings = {
    "keyboard.dispatch" = "keyCode";
    "workbench.colorTheme" = "Gruvbox Dark (Medium)";
    "explorer.confirmDragAndDrop" = false;
    "go.formatTool" = "goimports";
    "go.useLanguageServer" = true;
    "vim.normalModeKeyBindingsNonRecursive" = [
        {
            "before" = [
                "<leader>"
                "f"
            ];
            "commands" = [
                "workbench.action.files.saveWithoutFormatting"
            ];
        }
        {
            "before" = [
                "<leader>"
                "w"
            ];
            "commands" = [
                "editor.action.formatDocument"
                "workbench.action.files.save"
            ];
        }
    ];
    "vim.leader" = " ";
    "vim.highlightedyank.enable" = true;
    "editor.lineNumbers" = "relative";
    "vim.useSystemClipboard" = true;
    "bazel.buildifierPath" = "/home/bren077s/go/bin/buildifier";
    "files.exclude" = {
        "bazel*" = true;
    };
    "files.watcherExclude" = {
        "bazel*/**" = true;
    };
    "C_Cpp.clang_format_style" = "Google";
    "vim.sneakReplacesF" = true;
    "vim.sneak" = true;
    "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[json]" = {
        "editor.defaultFormatter"  = "esbenp.prettier-vscode";
    };
    "[html]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[rust]" = {
        "editor.defaultFormatter" = "rust-lang.rust";
    };
  };
}
