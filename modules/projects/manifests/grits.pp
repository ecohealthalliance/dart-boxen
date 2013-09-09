class projects::grits {
  boxen::project { 'grits':
    source => 'ecohealthalliance/grits',
  }

  python::mkvirtualenv { 'grits':
    project_dir => "${boxen::config::srcdir}/grits",
  }

  python::requirements { 'grits':
    requirements => "${boxen::config::srcdir}/grits/server/requirements.txt",
    virtualenv   => 'grits',
  }
}