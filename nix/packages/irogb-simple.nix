{
  lib,
  stdenv,
  cmake,
  fetchFromGitHub,
  ninja,
  pkg-config,
  raylib,
  libxrandr,
  libxcursor,
  libxinerama,
  libxi,
  libxext,
}:

let
  raylib-src = fetchFromGitHub {
    owner = "raysan5";
    repo = "raylib";
    rev = "5.0";
    hash = "sha256-gEstNs3huQ1uikVXOW4uoYnIDr5l8O9jgZRTX1mkRww=";
  };
in
stdenv.mkDerivation {
  pname = "irogb-simple";
  version = "1.0.0";
  src = ../..;

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
  ];

  buildInputs = [
    raylib
    libxrandr
    libxcursor
    libxinerama
    libxi
    libxext
  ];

  cmakeFlags = [
    "-DBUILD_LIBRETRO=OFF"
    "-DBUILD_FULL=OFF"
    "-DBUILD_SIMPLE=ON"
    "-DBUILD_PYTHON=OFF"
    "-DCMAKE_BUILD_TYPE=Release"

    # Same justification is already justified in `nix/packages/irogb-full.nix`.
    "-DFETCHCONTENT_FULLY_DISCONNECTED=OFF"
    "-DFETCHCONTENT_SOURCE_DIR_RAYLIB=${raylib-src}"
  ];

  postInstall = ''
    install -Dm755 src/frontend/raylib/irogb_simple \
        "$out/bin/irogb-simple"
  '';

  meta = {
    description = "IroGB Game Boy Color minimal raylib frontend";
    homepage = "https://kaze.moe/TismForge/IroGB";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
  };
}
