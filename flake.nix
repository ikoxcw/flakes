{
  description = "Description for the project";


  outputs = inputs@{ self, ... }:
    let
      selfPkgs = import ./pkgs;
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      systems = [ "x86_64-linux" ];
      imports = [
        ./home/profiles
        ./hosts
        ./module
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule

      ] ++ [
        inputs.flake-root.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      flake = {
        overlays.default = selfPkgs.overlay;
      };
      # systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, pkgs, system, ... }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        # packages.default = pkgs.hello;

        # NOTE: These overlays apply to the Nix shell only. See `modules/nix.nix` for system overlays.
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            #inputs.foo.overlays.default
          ];
        };

        treefmt.config = {
          inherit (config.flake-root) projectRootFile;
          package = pkgs.treefmt;
          programs.nixpkgs-fmt.enable = true;
          programs.prettier.enable = true;
          programs.taplo.enable = true;
          programs.shfmt.enable = true;
        };

        devShells = {
          # run by `nix devlop` or `nix-shell`(legacy)
          # Temporarily enable experimental features, run by`nix develop --extra-experimental-features nix-command --extra-experimental-features flakes`
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [ git neovim sbctl just ];
            inputsFrom = [
              config.flake-root.devShell
            ];
          };
          # run by `nix develop .#<name>`
          # NOTE: Here are some of the steps I documented, see `https://github.com/Mic92/sops-nix` for more details
          # ```
          # mkdir -p ~/.config/sops/age
          # age-keygen -o ~/.config/sops/age/keys.txt
          # age-keygen -y ~/.config/sops/age/keys.txt
          # sudo mkdir -p /var/lib/sops-nix
          # sudo cp ~/.config/sops/age/keys.txt /var/lib/sops-nix/
          # nvim $FLAKE_ROOT/.sops.yaml
          # mkdir $FLAKE_ROOT/secrets
          # sops $FLAKE_ROOT/secrets/secrets.yaml
          # ```
          secret = pkgs.mkShell {
            name = "secret";
            nativeBuildInputs = with pkgs; [ sops age neovim ssh-to-age ];
            shellHook = ''
              export $EDITOR=nvim
              export PS1="\[\e[0;31m\](Secret)\$ \[\e[m\]"
            '';
            inputsFrom = [
              config.flake-root.devShell
            ];
          };
        };

      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };


  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    disko.url = "github:nix-community/disko";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-registry = {
      url = "github:NixOS/flake-registry";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # hycov = {
    #   url = "github:DreamMaoMao/hycov";
    #   inputs.hyprland.follows = "hyprland";
    # };
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprland-contrib.url = "github:hyprwm/contrib";

    nixd.url = "github:nix-community/nixd";
    nvim-flake.url = "github:ikoxcw/nvim-flake";
    # nvim-flake.url = "/home/kotori/Documents/nvim-flake";
    # nvim-flake.url = "github:Ruixi-rebirth/nvim-flake";
    ikoxcw-sec = {
      url = "git+ssh://git@github.com/ikoxcw/secrets.git?ref=main&shallow=1";
      flake = false;
    };
    ikoxcw = {
      url = "github:ikoxcw/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tlock = {
      url = "git+https://github.com/eklairs/tlock?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    sops-nix.url = "github:Mic92/sops-nix";
    yazi.url = "github:sxyazi/yazi";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

  };
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      # "https://hyprland.cachix.org"
      "https://ruixi-rebirth.cachix.org"
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://cache.garnix.io"
      "https://gomibox.cachix.org"
      "https://yazi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "ruixi-rebirth.cachix.org-1:sWs3V+BlPi67MpNmP8K4zlA3jhPCAvsnLKi4uXsiLI4="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "gomibox.cachix.org-1:M3V3Xzc+tMCxAMf4GzGkhGebm00Lk3vLEgU7f97JL/8="
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
    trusted-users = [ "root" "@wheel" ];
  };
}
