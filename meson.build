project('s7-reaper-repl', 'cpp', 'c',
       )

subdir('src')

iplug2_proj = subproject('iPlug2', default_options:
			 ['IGRAPHICS=NO_IGRAPHICS', ])

app = shared_library(
  'reaper_s7-reaper-repl',
  name_prefix: '', # skipping the lib prefix in linux
  dependencies: [
    iplug2_proj.get_variable('iplug2_RPR_dep'),
    app_dep, # from src/
  ],
  install: true,
  )
