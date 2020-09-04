#include "./bindings.h"
// #include "ReaperExt_include_in_plug_hdr.h"
// #include "ReaperExt_include_in_plug_src.h"

#include "reaper_plugin_functions.h"

namespace reaper_repl {

namespace tracks {


s7_pointer count_tracks(s7_scheme* sc, s7_pointer) {
    return s7_make_integer(sc, CountTracks(0));
}

s7_pointer insert_track(s7_scheme* sc, s7_pointer) {
    InsertTrackAtIndex(GetNumTracks(), false);
    return s7_nil(sc);
}


void bind(s7_scheme* sc, s7_pointer env) {


    s7_define(sc, env, s7_make_symbol(sc, "count-tracks"),
              s7_make_function(sc, "count-tracks", count_tracks,
                               0, // req args
                               0, // optional args: thickness
                               false, // rest args
                               "(count-tracks &optional rpr-proj)"));

    s7_define(sc, env, s7_make_symbol(sc, "insert-track"),
              s7_make_function(sc, "insert-track", insert_track,
                               0, // req args
                               0, // optional args: thickness
                               false, // rest args
                               "(insert-track)"));
}

}


void bind(reaper_plugin_info_t* pRec, s7_scheme* sc) {
    s7_pointer env = s7_inlet(sc, s7_nil(sc));
    s7_gc_protect(sc, env);
    int gErrorCount = 0;
    // as seen in ReaperExt_include_in_plug_src.h
#define IMPAPI(x) if (!((*((void **)&(x)) = (void *)pRec->GetFunc(#x)))) gErrorCount++;


    IMPAPI(GetNumTracks);
    IMPAPI(CountTracks);
    IMPAPI(InsertTrackAtIndex);

    tracks::bind(sc, env);

    s7_define_variable(sc, "rpr", env);
}
}
