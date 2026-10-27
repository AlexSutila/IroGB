{
  lib,
  stdenv,
  cmake,
  fetchFromGitHub,
  ninja,
  pkg-config,
  sdl3,
  curl,
  nlohmann_json,
}:

let
  miniz-src = fetchFromGitHub {
    owner = "richgel999";
    repo = "miniz";
    rev = "2948eebafc5b9f1c69bebed80333e403a09bd62d";
    hash = "sha256-RSgNWSX+hiz8FLheh+vS6xHLL+Hkt5tbB6IvllWBt+c=";
  };

  picosha2-src = fetchFromGitHub {
    owner = "okdshin";
    repo = "PicoSHA2";
    rev = "161cb3fc4170fa7a3eca9e582cebd27cc4d1fe29";
    hash = "sha256-3psCzbrwR+vO9TyTKOx+gEaWuHDx6pSgLOQ3DqrJsnI=";
  };

  imgui-src = fetchFromGitHub {
    owner = "ocornut";
    repo = "imgui";
    rev = "4be0b47ecc0edd535a40a79f6ceb6f1ac5936483";
    hash = "sha256-g4pQOix8hXjBzoMNd2hScTf02psVQ0ucpuZ0nA4luqY=";
  };

  imgui-file-dialog-src = fetchFromGitHub {
    owner = "aiekick";
    repo = "ImGuiFileDialog";
    rev = "c761c6e67ab4541c6fd455e094cab220744c435f";
    hash = "sha256-Izl4YcMRYDfXRQot7H1o2yGANl6bZUpO+rrxARQyu6w=";
  };
in
stdenv.mkDerivation {
  pname = "irogb-full";
  version = "1.0.0";
  src = ../..;

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
  ];

  buildInputs = [
    sdl3
    curl
    nlohmann_json
  ];

  cmakeFlags = [
    "-DBUILD_LIBRETRO=OFF"
    "-DBUILD_FULL=ON"
    "-DBUILD_SIMPLE=OFF"
    "-DBUILD_PYTHON=OFF"
    "-DCMAKE_BUILD_TYPE=Release"

    # We explicitly supply the sources with deterministically pinned versions, so we
    # do not want cmake to actually make an attempt to fetch them itself.
    "-DFETCHCONTENT_FULLY_DISCONNECTED=OFF"

    # Tells cmake where the specified source directories of each dependency are located.
    "-DFETCHCONTENT_SOURCE_DIR_MINIZ=${miniz-src}"
    "-DFETCHCONTENT_SOURCE_DIR_PICOSHA2=${picosha2-src}"
    "-DFETCHCONTENT_SOURCE_DIR_IMGUI=${imgui-src}"
    "-DFETCHCONTENT_SOURCE_DIR_IMGUI_FILE_DIALOG=${imgui-file-dialog-src}"

    # Need this because ImGuiFileDialog's standalone CMake target was getting compiled
    # without ImGui's include directory. Gotta point it to the right place.
    "-DCMAKE_CXX_FLAGS=-I${imgui-src}"
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 src/frontend/sdl3/irogb_full \
      "$out/bin/irogb-full"
    runHook postInstall
  '';

  meta = {
    description = "IroGB Game Boy Color SDL3 with debugger";
    homepage = "https://kaze.moe/TismForge/IroGB";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
  };
}
