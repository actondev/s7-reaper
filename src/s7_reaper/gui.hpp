#pragma once

#include <string>
#include "reaper_plugin.h"

namespace s7_reaper {
namespace gui {

/**
 * Starts a thread where the gui is shown.
 *
 * The passed file path is a scheme file with the (draw) function defined.
 * This also creates a new s7_scheme* instance
 */
void init(reaper_plugin_info_t* pRec, std::string file);
}
}
