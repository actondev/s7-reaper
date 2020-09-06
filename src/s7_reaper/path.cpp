#include <string>

#if defined(__linux__)
#include <dlfcn.h>
#endif

#ifdef _WIN32
#include <Windows.h>
#include <libloaderapi.h>
#endif

namespace s7_reaper {

namespace path {

#if defined(__linux__)
__attribute__((constructor))
void on_load(void) {
    Dl_info dl_info;
    dladdr((void*) on_load, &dl_info);
    fprintf(stderr, "module %s loaded\n", dl_info.dli_fname);
}

#endif


std::string get() {

#if defined(__linux__)
    // https://stackoverflow.com/questions/1681060/library-path-when-dynamically-loaded
    Dl_info dl_info;
    dladdr((void*) on_load, &dl_info);
    std::string path(dl_info.dli_fname);

    return path;
#elif defined(_WIN32)
    // TODOOOOO

    TCHAR path[2048];
    GetModuleFileName(NULL, path, 2048);
    std::string path_str = path;

    char path_char[MAX_PATH];
    HMODULE hm = NULL;

    if (GetModuleHandleEx(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
                          GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                          (LPCSTR)&aod::vst3::path, &hm) == 0)
    {
        int ret = GetLastError();
        fprintf(stderr, "GetModuleHandle failed, error = %d\n", ret);
        // Return or however you want to handle an error.
    }
    if (GetModuleFileName(hm, path, sizeof(path_char)) == 0)
    {
        int ret = GetLastError();
        fprintf(stderr, "GetModuleFileName failed, error = %d\n", ret);
        // Return or however you want to handle an error.
    }
    //fprintf(stderr, "Got vst3 path %s\n", path_char);


    return path_str;
#else
#error "aod::vst3::path() not implemented in this platform"
#endif
}

}
}
