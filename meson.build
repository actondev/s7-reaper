project('s7-reaper', 'cpp', 'c',
        default_options: [
        'cpp_std=c++17',
        'default_library=static',]
       )

iplug2_proj = subproject('iPlug2', default_options:
			 ['IGRAPHICS=NO_IGRAPHICS', ])
			 
s7bi_proj = subproject('s7bi',
		       default_options:[
			 'curl=enabled',
			 'json=enabled'
		       ])
s7bi_dep = s7bi_proj.get_variable('s7bi_dep')

imgui_proj = subproject('imgui')
imgui_dep = imgui_proj.get_variable('imgui_dep')

subdir('lib')
subdir('src')

cmake = import('cmake')
sfml_opt = cmake.subproject_options()
sfml_opt.add_cmake_defines({'SFML_BUILD_AUDIO': false,
			    'SFML_BUILD_GRAPHICS': false,
			    'SFML_BUILD_NETWORK': false,
			    # 'SFML_STATIC_LIBRARIES': true,
			    'BUILD_SHARED_LIBS': false,})
sfml_opt.append_compile_args('cpp', '-fPIC')

sfml_proj = cmake.subproject('SFML', options: sfml_opt)
# Fetch the dependency object
sfml_system_dep = sfml_proj.dependency('sfml-system')
# sfml_graphics_dep = sfml_proj.dependency('sfml-graphics')
sfml_window_dep = sfml_proj.dependency('sfml-window')
# sfml_network_dep = sfml_proj.dependency('sfml-network')
# sfml_audio_dep = sfml_proj.dependency('sfml-audio')

sfml_dep = [sfml_system_dep,
	    # we don't need the graphics
	    # and we save ~4mb :)
	    # sfml_graphics_dep,
	    sfml_window_dep,
	    # sfml_network_dep,
	    # sfml_audio_dep,
	   ]



# SFML_proj = subproject('SFML')
# SFML_dep = SFML_proj.get_variable('SFML_dep')

app = shared_library(
  'reaper_s7-reaper',
  name_prefix: '', # skipping the lib prefix in linux
  dependencies: [
    iplug2_proj.get_variable('iplug2_RPR_dep'),
    s7bi_dep,
    imgui_dep,
    sfml_dep,
    sfml_imgui_dep,
    app_dep, # from src/
  ],
  # shared libraries (eg curl) are going to be located in the ./s7-reaper-lib
  # this is when the extension is installed to the REAPER/UserPlugins/ dir
  build_rpath: '$ORIGIN/s7-reaper-lib',
  install: true,
  )
