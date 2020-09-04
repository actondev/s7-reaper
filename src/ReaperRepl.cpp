#include "ReaperRepl.h"
#include "ReaperExt_include_in_plug_src.h"
#include "reaper_plugin_functions.h"
#include <iostream>
#include <sstream>
#include <filesystem>
#include <iostream>

#include "bindings.h"
#include "aod/path.hpp"
#include "aod/s7.hpp"

#include "imgui.h"


using std::cout;
using std::cerr;
using std::endl;
namespace fs = std::filesystem;


thread_local ImGuiContext* MyImGuiTLS = NULL;

ReaperRepl::ReaperRepl(reaper_plugin_info_t* pRec)
    : ReaperExtBase(pRec)
{
    //Use IMPAPI to register any Reaper APIs that you need to use
//   IMPAPI(GetNumTracks);
//   IMPAPI(CountTracks);
//   IMPAPI(InsertTrackAtIndex);

    std::string path = aod::path::get();
    printf("path is %s\n", path.c_str());

//   s7_scheme* sc = s7_init();
    fs::path base_path = fs::path(path).remove_filename();
    fs::path scheme_path = base_path / "s7_reaper";
    cerr << "scheme path is " << scheme_path << '\n';

    s7_scheme* sc = aod::s7::init(scheme_path);
    reaper_repl::bind(pRec, sc);
    aod::s7::load_file(sc, "init.scm");
    this->repl = aod::s7::Repl(sc);

    // mMakeGraphicsFunc = [&]() {
    // return MakeGraphics(*this, PLUG_WIDTH, PLUG_HEIGHT, PLUG_FPS);
    // };

    //Define some lambdas that can be called from either GUI widgets or in response to commands
    auto action1 = []() {
        printf("message box\n");
//     MessageBox(gParent, "Action 1!", "Reaper extension test", MB_OK); //gParent
    };

    auto action2 = []() {
        InsertTrackAtIndex(GetNumTracks(), false);
    };

    //Register an action. args: name: lambda, add menu item,
    RegisterAction("IPlugReaperExtension: Action 1 - MsgBox", action1, true);
    RegisterAction("IPlugReaperExtension: Action 2 - AddTrack", action2, true);
    // RegisterAction("IPlugReaperExtension: Action 3 - Show/Hide UI", [&]() { ShowHideMainWindow(); mGUIToggle = !mGUIToggle; }, true, &mGUIToggle);

    cb = [&](const char *data) -> std::string {
        printf("main: got data %s\n", data);

        std::ostringstream stream;
        stream << "Got " << strlen(data) << " chars" << std::endl;
        std::string str = stream.str();
//         printf("

//         InsertTrackAtIndex(GetNumTracks(), false);

        std::string res;
        if(repl.handleInput(data)) {
            res = repl.evalLastForm();
        }

        return res + "\n> ";
    };

    srv.listen(1234, cb, "s7-reaper-repl\n> ");
    printf("started listening at 1234\n");
}

void ReaperRepl::OnIdle()
{
    int tracks = CountTracks(0);

    if(tracks != mPrevTrackCount) {
        mPrevTrackCount = tracks;

        // if(GetUI()) {
        //   dynamic_cast<ITextControl*>(GetUI()->GetControlWithTag(kCtrlTagText))->SetStrFmt(64, "NumTracks: %i", tracks);
        // }
    }
}
