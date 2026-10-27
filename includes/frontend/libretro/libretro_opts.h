#ifndef GBC_LIBRETRO_FRONTEND_OPTS_HPP
#define GBC_LIBRETRO_FRONTEND_OPTS_HPP
#include <cstddef>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Just a heads up, I don't know what the deal is but the formatter REALLY loves making an absolute mess
 * of this file. If you need to selectively disable the formatter to keep this file readable, please do.
 */
#include "frontend/libretro/libretro.h"

static const struct retro_core_option_v2_category irogb_system_cat = {
    // clang-format off
    .key = "system",
    .desc = "system",
    .info = "System hardware, performance, and BIOS settings",
    // clang-format on
};

static const struct retro_core_option_v2_category irogb_video_cat = {
    // clang-format off
    .key = "video",
    .desc = "video",
    .info = "System hardware, performance, and BIOS settings",
    // clang-format on
};

static struct retro_core_option_v2_category irogb_opt_cats[] = {
    irogb_system_cat,
    irogb_video_cat,
    {NULL, NULL},
};

static struct retro_core_option_v2_definition irogb_bios_opt = {
    // clang-format off
    .key                = "irogb_bios",
    .desc               = "Boot ROM / BIOS",
    .desc_categorized   = NULL,
    .info = "Selects which BIOS to execute to initialize the GameBoyColor hardware, including "
            "re-colorization features. If this feature is not enabled or the BIOS file is not "
            "found, an internal fallback routine is run that performs similar a initialization "
            "process.",
    .category_key       = "system",
    .values             = {{"auto", "Auto"},
                           {"dmg", "DMG BIOS"},
                           {"cgb", "CGB BIOS"},
                           {"none", "Skip BIOS"},
                           {0}},
    .default_value      = "auto",
    // clang-format on
};

static const struct retro_core_option_v2_definition irogb_big_step_opt = {
    // clang-format off
    .key                = "irogb_big_step",
    .desc               = "Big-step CPU optimization (experimental)",
    .desc_categorized   = NULL,
    .info = "Emulates multiple CPU cycles in bulk all at once and makes remaining hardware "
            "components play catchup afterwards. This optimization is designed to take these "
            "kinds of shortcuts without harming overall emulation accuracy, and is evaluated "
            "to the same level of scrutiny as conventional single cycle stepped emulation is.",
    .info_categorized   = NULL,
    .category_key       = "system",
    .values             = {{"enabled", "enabled"}, {"disabled", "disabled"}, {0}},
    // TODO: Eventually this should be enabled by default after we have enough confidence that
    // this is truly stable enough to be used as the default emulation driver.
    .default_value      = "disabled",
    // clang-format on
};

static const struct retro_core_option_v2_definition irogb_monochrome_dmg_opt = {
    // clang-format off
    .key                = "irogb_monochrome_dmg",
    .desc               = "Force monochrome in DMG backwards compatability",
    .desc_categorized   = NULL,
    .info_categorized   = NULL,
    .category_key       = "video",
    .values             = {{"enabled", "enabled"}, {"disabled", "disabled"}, {0}},
    .default_value      = "disabled",
    // clang-format on
};

static struct retro_core_option_v2_definition irogb_opt_defs[] = {
    // System
    irogb_bios_opt,
    irogb_big_step_opt,
    // Video
    irogb_monochrome_dmg_opt,
    {NULL, NULL},
};

[[maybe_unused]] static struct retro_core_options_v2 irogb_opts = {
    irogb_opt_cats,
    irogb_opt_defs,
};

#ifdef __cplusplus
}
#endif

#endif // GBC_LIBRETRO_FRONTEND_OPTS_HPP
