#pragma once

#include "s7.h"
#include "reaper_plugin.h"
#include "ReaperExtBase.h"

namespace s7_reaper {
namespace bindings {
// the ReaperExtBase instance is needed for the RegisterAction
// pRec is needed for access to reaper's API
void bind(iplug::ReaperExtBase* instance, reaper_plugin_info_t* pRec, s7_scheme* sc);
}
}
