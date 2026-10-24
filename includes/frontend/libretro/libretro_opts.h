#ifndef GBC_LIBRETRO_FRONTEND_OPTS_HPP
#define GBC_LIBRETRO_FRONTEND_OPTS_HPP
#include <cstddef>

#ifdef __cplusplus
extern "C" {
#endif
#include "frontend/libretro/libretro.h"

static struct retro_core_option_v2_category irogb_opt_cats[] = {
    {
     .key = "system",
     .desc = "system",
     .info = "System hardware, performance, and BIOS settings",
     },
    {
     .key = "video",
     .desc = "video",
     .info = "Graphical settings",
     },
    {0},
};

static struct retro_core_option_v2_definition irogb_opt_defs[] = {
    {
     .key = "irogb_bios",
     .desc = "Select bios boot rom.",
     .desc_categorized = NULL,
     .info_categorized = NULL,
     .category_key = "system",
     .values = {{"auto", "Auto"},
                   {"dmg", "DMG BIOS"},
                   {"cgb", "CGB BIOS"},
                   {"none", "Skip BIOS"},
                   {0}},
     .default_value = "auto",
     },

    {
     .key = "irogb_monochrome_dmg",
     .desc = "Force monochrome in DMG backwards compatability",
     .desc_categorized = NULL,
     .info_categorized = NULL,
     .category_key = "video",
     .values = {{"enabled", "enabled"}, {"disabled", "disabled"}, {0}},
     .default_value = "disabled",
     },

    {0},
};

static struct retro_core_options_v2 irogb_opts = {
    irogb_opt_cats,
    irogb_opt_defs,
};

#ifdef __cplusplus
}
#endif

#endif // GBC_LIBRETRO_FRONTEND_OPTS_HPP
