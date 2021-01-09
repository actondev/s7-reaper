#include "ReaperRepl.h"
#include "ReaperExt_include_in_plug_src.h"
#include "reaper_plugin_functions.h"
#include <iostream>
#include <sstream>
#include <filesystem>
#include <iostream>

#include "s7_reaper/bindings.hpp"
#include "s7_reaper/path.hpp"
// #include "aod/s7.hpp"
#include <s7bi/s7bi.hpp>

using std::cout;
using std::cerr;
using std::endl;
namespace fs = std::filesystem;

#include "imgui.h"
thread_local ImGuiContext* MyImGuiTLS = NULL;

ReaperRepl::ReaperRepl(reaper_plugin_info_t* pRec)
    : ReaperExtBase(pRec)
{

    printf("here, this is %p\n", this);
    std::string path = s7_reaper::path::get();
    printf("path is %s\n", path.c_str());

    fs::path base_path = fs::path(path).remove_filename();
    fs::path scheme_path = base_path / "s7-reaper";
    cerr << "scheme path is " << scheme_path << '\n';

    // the aod.core etc are located in the s7-imgui subdir of the scheme path
    // TODO .. how should I manage this? (this is at least during development
    // so that I can work in s7-imgui for core things, and then use these .scm files)
    sc = s7bi::init(scheme_path);
//     sc = aod::s7::init(scheme_path / "s7-imgui");
    // adding our own files to the load path
    s7_add_to_load_path(sc, scheme_path.string().c_str());

    s7_reaper::bindings::bind(this, pRec, sc);
    s7bi::load_file(sc, "init.scm");
    
    // a socket repl should be started by scheme with dyad :)
}

void ReaperRepl::OnIdle()
{
    // is on idle called?
}
