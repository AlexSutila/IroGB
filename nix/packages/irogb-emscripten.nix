{
  lib,
  stdenv,
  cmake,
  ninja,
  emscripten,
  fetchFromGitHub,
  python3,
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
  pname = "irogb-emscripten";
  version = "1.0.0";
  src = ../..;

  nativeBuildInputs = [
    cmake
    ninja
    emscripten

    # For convenience sake, we package a utility script to make it easy to run
    python3
  ];

  cmakeFlags = [
    "-DCMAKE_TOOLCHAIN_FILE=${emscripten}/share/emscripten/cmake/Modules/Platform/Emscripten.cmake"

    "-DBUILD_LIBRETRO=OFF"
    "-DBUILD_FULL=OFF"
    "-DBUILD_SIMPLE=ON"
    "-DBUILD_PYTHON=OFF"
    "-DCMAKE_BUILD_TYPE=Release"

    # Same justification is already justified in `nix/packages/irogb-full.nix`.
    "-DFETCHCONTENT_FULLY_DISCONNECTED=OFF"
    "-DFETCHCONTENT_SOURCE_DIR_RAYLIB=${raylib-src}"
  ];

  installPhase = ''
    runHook preInstall
    install -d "$out/share/irogb-emscripten"
    install -m644 index.html index.js index.wasm app.css app.js coi-serviceworker.js \
      "$out/share/irogb-emscripten/"
    install -Dm755 ${./irogb-emscripten-server.py} \
      "$out/bin/irogb-emscripten"
    patchShebangs "$out/bin/irogb-emscripten"
    runHook postInstall
  '';

  meta = {
    description = "IroGB Game Boy Color WebAssembly frontend";
    homepage = "https://kaze.moe/TismForge/IroGB";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
  };
}
