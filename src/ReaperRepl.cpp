#include "ReaperRepl.h"
#include "ReaperExt_include_in_plug_src.h"
#include "reaper_plugin_functions.h"
#include <iostream>
#include <sstream>
#include <filesystem>
#include <iostream>

#include "s7_reaper/bindings.hpp"
#include "s7_reaper/path.hpp"
#include "aod/s7.hpp"

#include "imgui.h"
#include "imgui_impl_sdl.h"
#include "imgui_impl_opengl2.h"
#include "SDL_opengl.h"


using std::cout;
using std::cerr;
using std::endl;
namespace fs = std::filesystem;


thread_local ImGuiContext* MyImGuiTLS = NULL;


int guiLoop() {

    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("Error: %s\n", SDL_GetError());
        return 1;
    }

    SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
    SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);
    SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 8);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 2);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 2);


    SDL_Window* window = SDL_CreateWindow("s7imgui - Gui Repl", 100, 100, 600, 400,
                                          // SDL_WINDOWPOS_CENTERED caused the app to not show on linux. wtf
                                          SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE);

    SDL_GLContext gl_context = SDL_GL_CreateContext(window);
    SDL_GL_MakeCurrent(window, gl_context);
    SDL_GL_SetSwapInterval(1);    // Enable vsync

// Setup Dear ImGui context
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();

    ImGuiIO& io = ImGui::GetIO();
    (void) io;
    ImGui::StyleColorsDark();

    bool sdlInit = ImGui_ImplSDL2_InitForOpenGL(window, gl_context);
    ImGui_ImplOpenGL2_Init();
    ImVec4 clear_color = ImVec4(0.45f, 0.55f, 0.60f, 1.00f);
    ImGui::PushStyleColor(ImGuiCol_WindowBg, IM_COL32(30, 30, 30, 255));

//     s7_pointer setup_fn = s7_name_to_value(sc, "setup");
//     if (setup_fn != s7_undefined(sc)) {
//         s7_call(sc, setup_fn, s7_nil(sc));
//     }

    //While application is running
//     bool have_drawn = false;
    unsigned int redraws_after_no_events = 0;
    bool running = true;
    // TODO remove this
    bool g_force_redraw = false;
    bool show_demo_window = true;
    while (running) {

        bool have_events = false;
//         std::unique_lock<std::mutex> lock_loop(g_gui_loop_mutex);

        SDL_Event e;

        //Handle events on queue
        while (SDL_PollEvent(&e) != 0) {
//            printf("SDL event\n");
            have_events = true;
            redraws_after_no_events = 0;
            //User requests quit
            switch (e.type) {
            case SDL_QUIT:
                printf("SDL_QUIT event\n");
                running = false;
                break;
            case SDL_MOUSEBUTTONDOWN:
            case SDL_MOUSEBUTTONUP:
//                     fprintf(stderr, "Mouse down/up at (%d,%d)\n", e.motion.x,
//                             e.motion.y);
                break;
            }
            ImGui_ImplSDL2_ProcessEvent(&e);
        }
        if (!running) {
            break;
        }

        if (redraws_after_no_events > 2 && !g_force_redraw) {
            // no need to redraw!
//             lock_loop.unlock();
            std::this_thread::sleep_for(std::chrono::milliseconds(10));
            continue;
        }
        g_force_redraw = false;

        if (!have_events) {
            redraws_after_no_events++;
        }

        ImGui_ImplOpenGL2_NewFrame();
        ImGui_ImplSDL2_NewFrame(window);
        ImGui::NewFrame();

//         s7_eval_c_string(sc, "(draw)");

        if (show_demo_window)
            ImGui::ShowDemoWindow(&show_demo_window);


        ImGui::Render();

        glViewport(0, 0, (int) io.DisplaySize.x, (int) io.DisplaySize.y);
        // glClearColor is freezing if the window has been closed
        glClearColor((GLclampf) clear_color.x, (GLclampf) clear_color.y,
                     (GLclampf) clear_color.z, (GLclampf) clear_color.w);
        glClear(GL_COLOR_BUFFER_BIT);
        //glUseProgram(0); // You may want this if using this code in an OpenGL 3+ context where shaders may be bound
        ImGui_ImplOpenGL2_RenderDrawData(ImGui::GetDrawData());
        SDL_GL_SwapWindow(window);

//         lock_loop.unlock();
        std::this_thread::sleep_for(std::chrono::milliseconds(10));
    }
    printf("guiLoop: quit gui event loop, cleaning up \n");

    ImGui_ImplOpenGL2_Shutdown();
    ImGui_ImplSDL2_Shutdown();
    ImGui::DestroyContext();

    SDL_GL_DeleteContext(gl_context);

    SDL_DestroyWindow(window);

    SDL_Quit();

    printf("guiLoop: ----- gui loop quit ------\n");
    return 0;
}

ReaperRepl::ReaperRepl(reaper_plugin_info_t* pRec)
    : ReaperExtBase(pRec)
{

    //Use IMPAPI to register any Reaper APIs that you need to use
//   IMPAPI(GetNumTracks);
//   IMPAPI(CountTracks);
//   IMPAPI(InsertTrackAtIndex);

    printf("here, this is %p\n", this);
    std::string path = s7_reaper::path::get();
    printf("path is %s\n", path.c_str());

    fs::path base_path = fs::path(path).remove_filename();
    fs::path scheme_path = base_path / "s7_reaper";
    cerr << "scheme path is " << scheme_path << '\n';

    sc = aod::s7::init(scheme_path);
    s7_reaper::bindings::bind(this, pRec, sc);
    this->repl = aod::s7::Repl(sc);
    aod::s7::load_file(sc, "init.scm");

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

    auto action_imgui = []() {
        new std::thread(guiLoop);
    };

    //Register an action. args: name: lambda, add menu item,
    RegisterAction("IPlugReaperExtension: Action 1 - MsgBox", action1, true);
    RegisterAction("IPlugReaperExtension: Action 2 - AddTrack", action2, true);
    RegisterAction("imgui demo", action_imgui, true);
    // RegisterAction("IPlugReaperExtension: Action 3 - Show/Hide UI", [&]() { ShowHideMainWindow(); mGUIToggle = !mGUIToggle; }, true, &mGUIToggle);

    cb = [&](const char *data) -> std::string {
//         printf("main: got data %s\n", data);

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
