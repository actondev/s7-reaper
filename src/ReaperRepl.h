#pragma once

#include "ReaperExt_include_in_plug_hdr.h"
// #include "aod/net/net.hpp"
// #include "aod/s7/repl.hpp"
#include "s7.h"

enum EControlTags
{
    kCtrlTagText = 0,
    kNumCtrlTags
};

using namespace iplug;
using namespace igraphics;

class ReaperRepl : public ReaperExtBase
{
public:
    ReaperRepl(reaper_plugin_info_t* pRec);
    void OnIdle() override;
    void OnUIClose() override {
        mGUIToggle = 0;
    }

private:
    int mPrevTrackCount = 0;
    int mGUIToggle = 0;
//     aod::net::TcpServer srv;
//     aod::net::Callback cb;
//     aod::s7::Repl repl;
    s7_scheme* sc;
};

