let
  pkgs = import <nixpkgs> {};
in
{
  enable = true;
  extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
  ];
}
