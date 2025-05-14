let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    delta
    fish
    fzf
    lua-language-server
    neovim
    ripgrep
  ];

  GREETING = "Hello, Nix!";

  shellHook = ''
      # Start fish
      exec fish
  '';
}
