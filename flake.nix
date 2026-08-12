{
  description = "reasonix — cache-first DeepSeek coding agent for the terminal";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        reasonix = import ./nix/package.nix {inherit pkgs;};
      in {
        inherit reasonix;
        default = reasonix;
      });

    nixosModules.default = import ./nix/nixos.nix;
    homeManagerModules.default = import ./nix/hm.nix;
  };
}
