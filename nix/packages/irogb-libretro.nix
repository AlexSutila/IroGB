{
  lib,
  stdenv,
  cmake,
  ninja,
}:

stdenv.mkDerivation {
  pname = "irogb-libretro";
  version = "1.0.0";
  src = ../..;

  nativeBuildInputs = [
    cmake
    ninja
  ];

  cmakeFlags = [
    "-DBUILD_LIBRETRO=ON"
    "-DBUILD_FULL=OFF"
    "-DBUILD_SIMPLE=OFF"
    "-DBUILD_PYTHON=OFF"
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 src/frontend/libretro/irogb_libretro.so \
      "$out/lib/libretro/irogb_libretro.so"
    runHook postInstall
  '';

  meta = {
    description = "IroGB Game Boy Color libretro core";
    homepage = "https://kaze.moe/TismForge/IroGB";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
  };
}
