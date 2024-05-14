with import <nixpkgs> {};
mkShell {
  packages = [
    rustup mdbook
  ];
}
