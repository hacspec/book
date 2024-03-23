with import <nixpkgs> {};
mkShell {
  packages = [
    rustup
    # (writeScriptBin "mdbook-hax" ''
      
    # '')
  ];
}
