# Builds the reasonix CLI from source.
#
# version tracks the vendored commit (updated when the flake is refreshed).
# To compute vendorHash after updating go.mod/go.sum:
#   nix build .#reasonix --impure 2>&1 | grep 'got:' | awk '{print $2}'
{pkgs}:
let
  lib = pkgs.lib;
in
  pkgs.buildGoModule (finalAttrs: {
    pname = "reasonix";
    version = "1.24.1";

    src = lib.cleanSource ../.;

    vendorHash = "sha256-uKrReMcR7L+8E4t/jY32/YW11bXROgtwl9kl4KxgQdM=";

    # Only the CLI main; nested modules (desktop/, sdk/go/) are separate Go
    # modules and must not be swept up by `go build ./...`.
    subPackages = ["cmd/reasonix"];

    ldflags = [
      "-X main.version=${finalAttrs.version}"
      "-X main.gitCommit=71c7c6f3e475"
      # Reproducible placeholder; reasonix --version only needs the version line.
      "-X main.buildTimeUTC=1970-01-01T00:00:00Z"
    ];

    meta = {
      description = "Cache-first DeepSeek coding agent for the terminal";
      homepage = "https://github.com/esengine/deepseek-reasonix";
      license = lib.licenses.mit;
      mainProgram = "reasonix";
    };
  })
