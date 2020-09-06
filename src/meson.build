sources = files(
  'ReaperRepl.cpp',
  # s7_reaper
  's7_reaper/path.cpp',
  's7_reaper/bindings.cpp',
  's7_reaper/gui.cpp',
)

# can be filled by subdirs
includes = []

includes += include_directories('.')

subdir('resources')

app_dep = declare_dependency(
  include_directories: includes,
  sources: sources,
  )
