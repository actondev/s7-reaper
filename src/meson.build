sources = files(
  'ReaperRepl.cpp',
  'bindings.cpp',
  'aod/path.cpp',
)

# can be filled by subdirs
includes = []

includes += include_directories('.')

subdir('resources')

app_dep = declare_dependency(
  include_directories: includes,
  sources: sources,
  )
