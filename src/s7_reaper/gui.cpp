#include "./gui.hpp"
#include <string>
#include "s7_reaper/path.hpp"
#include "s7_reaper/bindings.hpp"
#include <filesystem>
#include "aod/s7.hpp"
#include <thread>

// gui things
// #include "SDL.h"
// #include "imgui.h"
// #include "imgui_impl_sdl.h"
// #include "imgui_impl_opengl2.h"
// #include "SDL_opengl.h"

// imgui
#include "imgui.h"
#include "imgui_impl_opengl2.h"
// sfml
#include <SFML/Window.hpp>
// #include <SFML/Graphics.hpp>
#include <SFML/OpenGL.hpp>
#include "aod/imgui/imgui-SFML.h"


namespace s7_reaper {
namespace gui {

namespace fs = std::filesystem;

int guiLoop(s7_scheme* sc); // defined later

/**
 * Starts a thread where the gui is shown.
 *
 * The passed file path is a scheme file with the (draw) function defined.
 * This also creates a new s7_scheme* instance
 */
void init(reaper_plugin_info_t* pRec, std::string file) {
    printf("gui init with file %s\n", file.c_str());
    std::string path = s7_reaper::path::get();

    fs::path base_path = fs::path(path).remove_filename();
    fs::path scheme_path = base_path / "s7-reaper";

    s7_scheme* sc = aod::s7::init(scheme_path);
    // passing NULL instance
    // by having a NULL instance, I won't be able to register actions/guis
    // which is fine. this should only happen on start up
    s7_reaper::bindings::bind(NULL, pRec, sc);
    aod::s7::load_file(sc, "init.scm");
    aod::s7::load_file(sc, file.c_str());

    std::thread t(guiLoop, sc);
    t.detach();
}

int guiLoop(s7_scheme* sc) {

    sf::Window window(sf::VideoMode(200, 200), "s7rpr");


    IMGUI_CHECKVERSION();
    ImGui::CreateContext();

    ImGuiIO& io = ImGui::GetIO();
    (void) io;
    ImGui::StyleColorsDark();

    ImGui::SFML::Init(window);
    ImGui_ImplOpenGL2_Init();
    ImVec4 clear_color = ImVec4(0.45f, 0.55f, 0.60f, 1.00f);
    ImGui::PushStyleColor(ImGuiCol_WindowBg, IM_COL32(30, 30, 30, 255));

    sf::Clock deltaClock;
    while (window.isOpen()) {
        sf::Event event;
        while (window.pollEvent(event)) {
            ImGui::SFML::ProcessEvent(event);

            if (event.type == sf::Event::Closed) {
                window.close();
            }
        }

        ImGui_ImplOpenGL2_NewFrame(); // builds the font (font atlas?)
        // actually, update calls new frame
        ImGui::SFML::Update(window, deltaClock.restart());
        // need to call ImGui::NewFrame?
        // nope.. it's crashing
        // Forgot to call Render() or EndFrame()  ???
        s7_eval_c_string(sc, "(draw)");

//         ImGui::ShowDemoWindow();
        ImGui::SFML::Render(window);
        window.display();

        std::this_thread::sleep_for(std::chrono::milliseconds(10));
    }
    
    ImGui_ImplOpenGL2_Shutdown();
//     ImGui::DestroyContext();
    ImGui::SFML::Shutdown();

    printf("s7 free called\n");
    s7_free(sc);
    return 0;
}

}
}
