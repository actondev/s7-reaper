#include "./bindings.hpp"
#include "reaper_plugin_functions.h"
#include "s7_reaper/gui.hpp"

namespace s7_reaper {

namespace bindings {
namespace sws {
void* FTOR_CF_ENUMERATE_ACTIONS = NULL; // set later upon binding

#define BUFFER_SIZE 1024
char buffer[BUFFER_SIZE];

s7_pointer cf_enumarate_actions(s7_scheme* sc, s7_pointer args) {
    if(FTOR_CF_ENUMERATE_ACTIONS != NULL) {
//         int CF_EnumerateActions(int section, int index, char* nameOut, int nameOut_sz)
        // or int (*ftor)(int,int, char*, int) = ...;
        auto ftor  = (int (*)(int,int, char*, int)) FTOR_CF_ENUMERATE_ACTIONS;
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

} // sws

namespace common {
s7_pointer main_on_command(s7_scheme* sc, s7_pointer args) {
    // 2nd arg flags.. what is "flags" ??
    Main_OnCommand(s7_real(s7_car(args)), 0);
    return s7_nil(sc);
}

s7_pointer update_arrage(s7_scheme* sc, s7_pointer) {
    UpdateArrange();
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

    s7_define(sc, env, s7_make_symbol(sc, "UpdateArrange"),
              s7_make_function(sc, "UpdateArrange", update_arrage,
                               0, 0, false,
                               "(UpdateArrange)"));

}
} // common

namespace tracks {

s7_pointer count_tracks(s7_scheme* sc, s7_pointer) {
    return s7_make_integer(sc, CountTracks(0));
}

s7_pointer insert_track(s7_scheme* sc, s7_pointer) {
    InsertTrackAtIndex(GetNumTracks(), false);
    return s7_nil(sc);
}


void bind(s7_scheme* sc, s7_pointer env) {
    // TODO count-tracks or CountTracks?
    // the 2nd keeps the same names as in the REAPER API doc : useful!!
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

namespace internal {
ReaProject* getCurrentProject() {
    // C: ReaProject* EnumProjects(int idx, char* projfnOutOptional, int projfnOutOptional_sz)
    //  idx=-1 for current project,projfn can be NULL if not interested in filename. use idx 0x40000000 for currently rendering project, if any.
    return EnumProjects(-1, NULL, 0);
}

s7_pointer register_action(s7_scheme* sc, s7_pointer args) {

    const char* name = s7_string(s7_car(args));
    args = s7_cdr(args);
    s7_pointer fn = s7_car(args);
    // TODO maybe s7_gc_protect the fn?
    auto cb = [sc,fn]() {
        s7_call(sc, fn, s7_nil(sc));
    };

    // perhaps the environment of here is.. outlet of curlet?
    // at the moment keep in mind that I define this environment globablly as "rpr"
//     iplug::ReaperExtBase* rpr = (iplug::ReaperExtBase*)s7_c_pointer(s7_eval_c_string(sc, "(rpr 'ReaperExtBase*)"));
    iplug::ReaperExtBase* rpr = (iplug::ReaperExtBase*)s7_c_pointer(s7_eval_c_string_with_environment(sc, "ReaperExtBase*", s7_curlet(sc)));
    if(rpr == NULL) {
//         fprintf(stderr, "ReaperExtBase* is NULL, cannot register action\n");
        return s7_nil(sc);
    }

    printf("Registering action %s\n", name);
    rpr->RegisterAction(name, cb, true);
    return s7_nil(sc);
}

s7_pointer register_gui(s7_scheme* sc, s7_pointer args) {
    const char* name = s7_string(s7_car(args));
    args = s7_cdr(args);
    const char* script_file = s7_string(s7_car(args));

    auto pRec = (reaper_plugin_info_t*)s7_c_pointer(s7_eval_c_string_with_environment(sc, "*reaper_plugin_info_t*", s7_curlet(sc)));
    if(pRec == NULL) {
//         fprintf(stderr, "*reaper_plugin_info_t* is NULL, cannot register gui\n");
        return s7_nil(sc);
    }
    auto cb = [pRec, script_file]() {
        printf("GUI: running script file %s\n", script_file);
        s7_reaper::gui::init(pRec, script_file);
    };

    // perhaps the environment of here is.. outlet of curlet?
    // at the moment keep in mind that I define this environment globablly as "rpr"
//     iplug::ReaperExtBase* rpr = (iplug::ReaperExtBase*)s7_c_pointer(s7_eval_c_string(sc, "(rpr 'ReaperExtBase*)"));
    iplug::ReaperExtBase* rpr = (iplug::ReaperExtBase*)s7_c_pointer(s7_eval_c_string_with_environment(sc, "ReaperExtBase*", s7_curlet(sc)));
    if(rpr == NULL) {
//         fprintf(stderr, "ReaperExtBase* is NULL, cannot register action\n");
        return s7_nil(sc);
    }
    
    printf("registering gui %s:%s\n", name, script_file);
    rpr->RegisterAction(name, cb, true);
    return s7_nil(sc);
}

void bind(s7_scheme* sc, s7_pointer env) {
    s7_define(sc, env, s7_make_symbol(sc, "RegisterAction"),
              s7_make_function(sc, "RegisterAction", register_action,
                               2, 0, false, //
                               "(RegisterAction name fn) Adds a menu item inside reaper"));

    s7_define(sc, env, s7_make_symbol(sc, "RegisterGui"),
              s7_make_function(sc, "RegisterGui", register_gui,
                               2, 0, false, //
                               "(RegisterGui name script-file) CUSTOM (not part of reaper): Registers an action under name which runs a gui script"));
}

}

namespace items {

int tag_media_item(s7_scheme* sc) {
    s7_pointer res = s7_eval_c_string(sc, "(rpr 'type-media-item)");
    if(s7_is_integer(res)) {
        return s7_integer(res);
    }
    s7_error(sc,
             s7_make_symbol(sc, "error"),
             s7_cons(sc, s7_make_string(sc, "type-media-item not defined in rpr"), s7_nil(sc)));
    return -1;
}

// returns <media-item {xyz-abc-xyz} 'active take name'>
s7_pointer to_string(s7_scheme* sc, s7_pointer args) {
    // checked? skipping for now
//     MediaItem* item = (MediaItem*) s7_c_object_value_checked(s7_car(args), tag_media_item(sc));
    MediaItem* item = (MediaItem*) s7_c_object_value(s7_car(args));
    if(item == NULL) {
        return s7_make_string(sc, "null");
    }
    MediaItem_Take* take = GetActiveTake(item);
    if(take == NULL) {
        return s7_make_string(sc, "null");
    }
    static char buffer[1024];
    GetSetMediaItemTakeInfo_String(take, "P_NAME", buffer, false);
    static char buffer_guid[32];
    GetSetMediaItemInfo_String(item, "GUID", buffer_guid, false);
    std::string str = "<media-item ";
    str += buffer_guid;
    str += " '";
    str += buffer;
    str += "'>";
    return s7_make_string(sc, str.c_str());
}

const char* help_count_selected = "(CountSelectedMediaItems) TODO pass ReaProject";
s7_pointer count_selected(s7_scheme* sc, s7_pointer) {
    return s7_make_integer(sc, CountSelectedMediaItems(0));
}

const char* help_set_selected = "(SetMediaItemSelected *media-item selected?)";
s7_pointer set_selected(s7_scheme* sc, s7_pointer args) {
    MediaItem* item = (MediaItem*) s7_c_object_value(s7_car(args));
    args = s7_cdr(args);
    bool sel = s7_boolean(sc, s7_car(args));

    printf("setting item %p sel %d\n", item, sel? 1 : 0);
    SetMediaItemSelected(item, sel);
    return s7_nil(sc);
}

const char* help_get_selected = "(GetSelectedMediaItem idx) TODO skipping first arg ReaProject ??";
s7_pointer get_selected(s7_scheme* sc, s7_pointer args) {
    // TODO be able to pass ReaProject?
    MediaItem* item = GetSelectedMediaItem(0, s7_integer(s7_car(args)));
    int tag = tag_media_item(sc);
    return s7_make_c_object(sc, tag, (void*) item);
}

void bind(s7_scheme* sc, s7_pointer env) {
    // types
    s7_int type = s7_make_c_type(sc, "<media-item>");
    s7_define(sc, env, s7_make_symbol(sc, "type-media-item"),
              s7_make_integer(sc, type));

    s7_c_type_set_to_string(sc, type, to_string);

    // functions
    s7_define(sc, env, s7_make_symbol(sc, "CountSelectedMediaItems"),
              s7_make_function(sc, "CountSelectedMediaItems", count_selected,
                               0, 0, false,
                               help_count_selected));

    s7_define(sc, env, s7_make_symbol(sc, "GetSelectedMediaItem"),
              s7_make_function(sc, "GetSelectedMediaItem", get_selected,
                               1, 0, false,
                               help_get_selected));

    s7_define(sc, env, s7_make_symbol(sc, "SetMediaItemSelected"),
              s7_make_function(sc, "SetMediaItemSelected", set_selected,
                               2, 0, false,
                               help_set_selected));

}
} // items


void bind(iplug::ReaperExtBase* inst, reaper_plugin_info_t* pRec, s7_scheme* sc) {
    s7_pointer env = s7_inlet(sc, s7_nil(sc));
    s7_gc_protect(sc, env);

    printf("registering instance %p\n", inst);
    s7_define_constant_with_environment(sc, env, "ReaperExtBase*", s7_make_c_pointer(sc, (void*)inst));
    s7_define_constant_with_environment(sc, env, "*reaper_plugin_info_t*", s7_make_c_pointer(sc, (void*)pRec));

    int gErrorCount = 0;
    // as seen in ReaperExt_include_in_plug_src.h
#define IMPAPI(x) if (!((*((void **)&(x)) = (void *)pRec->GetFunc(#x)))) gErrorCount++;

    IMPAPI(GetNumTracks);
    IMPAPI(CountTracks);
    IMPAPI(InsertTrackAtIndex);
    IMPAPI(Main_OnCommand);
    IMPAPI(UpdateArrange);


    // items
    IMPAPI(CountSelectedMediaItems);
    IMPAPI(GetSelectedMediaItem);
//     IMPAPI(SetMediaItemInfo_Value);
//     IMPAPI(SetMediaItemLength);
//     IMPAPI(SetMediaItemPosition);
    IMPAPI(SetMediaItemSelected);
//     IMPAPI(SetMediaItemTake_Source);
//     IMPAPI(SetMediaItemTakeInfo_Value);
//     IMPAPI(GetSetMediaItemInfo);
    IMPAPI(GetSetMediaItemInfo_String);
//     IMPAPI(GetSetMediaItemTakeInfo);
//     IMPAPI(GetSetMediaItemTakeInfo_String);

    // takes
    IMPAPI(GetActiveTake)
    IMPAPI(GetSetMediaItemTakeInfo_String);

    //project
    IMPAPI(EnumProjects);

    // dynamic actions aka registered by other scripts (see SWS)
    sws::FTOR_CF_ENUMERATE_ACTIONS = pRec->GetFunc("CF_EnumerateActions");

    items::bind(sc, env);
    tracks::bind(sc, env);
    common::bind(sc, env);
    sws::bind(sc, env);
    internal::bind(sc, env);

    s7_define_variable(sc, "rpr", env);
}
} // bindings
} // s7_reaper
