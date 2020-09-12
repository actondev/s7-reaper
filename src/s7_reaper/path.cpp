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
    char path_char[MAX_PATH];
    std::string path_str;
    HMODULE hm = NULL;

    if (GetModuleHandleEx(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
                          GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                          // pointing to our get function here
                          (LPCSTR)&get, &hm) == 0)
    {
        int ret = GetLastError();
        fprintf(stderr, "GetModuleHandle failed, error = %d\n", ret);
        return path_str;
    }
    if (GetModuleFileName(hm, path_char, sizeof(path_char)) == 0)
    {
        int ret = GetLastError();
        fprintf(stderr, "GetModuleFileName failed, error = %d\n", ret);
        return path_str;
    }

    path_str = path_char;
    return path_str;
#else
#error "s7_reaper::path::get() not implemented in this platform"
#endif
}

}
}
