{
  description = "irogb development shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        llvm = pkgs.llvmPackages_20;

        irogb-emscripten = pkgs.callPackage ./nix/packages/irogb-emscripten.nix { };
        irogb-libretro = pkgs.callPackage ./nix/packages/irogb-libretro.nix { };
        irogb-simple = pkgs.callPackage ./nix/packages/irogb-simple.nix { };
        irogb-full = pkgs.callPackage ./nix/packages/irogb-full.nix { };
      in
      {
        packages = {
          irogb-emscripten = irogb-emscripten;
          irogb-simple = irogb-simple;
          irogb-full = irogb-full;

          # This is by far going to be the most used frontend so...
          irogb-libretro = irogb-libretro;
          default = irogb-libretro;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cmake
            ninja
            pkg-config
            gnumake
            git
            gdb

            gcc14
            stdenv.cc.cc.lib
            llvm.clang-tools
            llvm.clang
            llvm.lld
            llvm.libcxx
            llvm.libcxx.dev

            python312
            python312Packages.pip
            emscripten

            sdl3
            curl
            nlohmann_json

            retroarch # for running the libretro core
            bear # for generating compile_commands.json
          ];

          shellHook = ''
            export VIRTUAL_ENV_DISABLE_PROMPT=1
            export QT_STYLE_OVERRIDE=Fusion
            export PS1="$PS1(irogb) "

            if [ ! -d .venv ]; then
                python3 -m venv .venv
            fi

            alias pytest="python3 -m pytest"
            alias pip="python3 -m pip"
            source .venv/bin/activate

            echo "Entered default irogb development shell"
          '';
        };
      }
    );
}
