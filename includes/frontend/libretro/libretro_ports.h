#ifndef GBC_LIBRETRO_FRONTEND_PORTS_HPP
#define GBC_LIBRETRO_FRONTEND_PORTS_HPP

#ifdef __cplusplus
extern "C" {
#endif

#include "frontend/libretro/libretro.h"

static const retro_controller_description irogb_default_port[] = {
    {"Game Boy Joypad", RETRO_DEVICE_JOYPAD},
    {          nullptr,                   0}
};

static const retro_controller_info irogb_ports[] = {
    {irogb_default_port, 1},
    {           nullptr, 0}
};

#ifdef __cplusplus
}
#endif

#endif // GBC_LIBRETRO_FRONTEND_PORTS_HPP
