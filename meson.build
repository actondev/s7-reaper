project('s7-reaper-repl', 'cpp', 'c',
        default_options: [
        'cpp_std=c++17',
        'default_library=static',]
       )

iplug2_proj = subproject('iPlug2', default_options:
			 ['IGRAPHICS=NO_IGRAPHICS', ])
			 
s7_imgui = subproject('s7_imgui')
s7_imgui_dep = s7_imgui.get_variable('s7_imgui_dep')

subdir('src')

app = shared_library(
  'reaper_s7-reaper-repl',
  name_prefix: '', # skipping the lib prefix in linux
  dependencies: [
    iplug2_proj.get_variable('iplug2_RPR_dep'),
    s7_imgui_dep,
    app_dep, # from src/
  ],
  install: true,
  )
