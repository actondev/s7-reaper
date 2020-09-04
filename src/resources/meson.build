includes += include_directories('.')


if host_machine.system() == 'windows'
  message('windows: compiling main.rc')
  
  # include_directories 
  sources += import('windows').compile_resources('main.rc',
						 include_directories: [
						   include_directories('fonts'),
						 ])
endif
