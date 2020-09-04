#include "./bindings.h"
// #include "ReaperExt_include_in_plug_hdr.h"
// #include "ReaperExt_include_in_plug_src.h"

#include "reaper_plugin_functions.h"

namespace reaper_repl {

namespace sws {
void* ftor_cf_enumarate_actions = NULL;
#define BUFFER_SIZE 1024
char buffer[BUFFER_SIZE];

s7_pointer cf_enumarate_actions(s7_scheme* sc, s7_pointer args) {
//     int (*cf_enumerate)(void*)
    if(ftor_cf_enumarate_actions != NULL) {
//         (*int)(int,int) ftor;
        // int CF_EnumerateActions(const int section, const int idx, char *nameBuf, const int nameBufSize)
//         int CF_EnumerateActions(int section, int index, char* nameOut, int nameOut_sz)
//         char* name[1024];
        auto ftor  = (int (*)(int,int, char*, int)) ftor_cf_enumarate_actions;
//         ftor()
        int section = s7_integer(s7_car(args));
        args = s7_cdr(args);
        int index = s7_integer(s7_car(args));
        int res = ftor(section, index, buffer, BUFFER_SIZE-1);

        // Lua: integer retval, string name = reaper.CF_EnumerateActions(integer section, integer index)
        return s7_list(sc,
                       2,
                       s7_make_integer(sc, res),
                       s7_make_string(sc, buffer));

    }
}

void bind(s7_scheme* sc, s7_pointer env) {
    s7_define(sc, env, s7_make_symbol(sc, "CF_EnumerateActions"),
              s7_make_function(sc, "CF_EnumerateActions", cf_enumarate_actions,
                               2, // req args
                               0, // optional args: thickness
                               false, // rest args
                               "(CF_EnumerateActions section idx) ret (retval:int name:string)"));
}


}

namespace common {
s7_pointer main_on_command(s7_scheme* sc, s7_pointer args) {
    // 2nd arg flags.. what is "flags" ??
    Main_OnCommand(s7_real(s7_car(args)), 0);
    return s7_nil(sc);
}

void bind(s7_scheme* sc, s7_pointer env) {
    // TODO should I keep the naming for the .."factory" functions?
    // and the create my own "wrappers" with normal dash-case?
    s7_define(sc, env, s7_make_symbol(sc, "Main_OnCommand"),
              s7_make_function(sc, "Main_OnCommand", main_on_command,
                               1, // req args
                               0, // optional args: thickness
                               false, // rest args
                               "(Main_OnCommand cmd-id)"));

}
}

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

    s7_define(sc, env, s7_make_symbol(sc, "main-on-command"),
              s7_make_function(sc, "main-on-command", insert_track,
                               0, // req args
                               0, // optional args: thickness
                               false, // rest args
                               "(main-on-command cmd-id)"));
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
    IMPAPI(Main_OnCommand);
//     IMPAPI(CF_EnumerateActions);

    sws::ftor_cf_enumarate_actions = pRec->GetFunc("CF_EnumerateActions");
    // int CF_EnumerateActions(const int section, const int idx, char *nameBuf, const int nameBufSize)
//     CF_EnumerateActions(0);
//     printf("CF_EnumerateActions is %p\n", CF_EnumerateActions);
//     IMPAPI(CF_

    tracks::bind(sc, env);
    common::bind(sc, env);
    sws::bind(sc, env);

    s7_define_variable(sc, "rpr", env);
}
}
