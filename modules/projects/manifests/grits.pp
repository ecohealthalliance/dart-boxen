class projects::grits {
  boxen::project { 'grits':
    source => 'ecohealthalliance/grits',
    notify => Exec['grits client setup'];
  }

  python::mkvirtualenv { 'grits':
    project_dir => "${boxen::config::srcdir}/grits",
  }

  python::requirements { 'grits':
    requirements => "${boxen::config::srcdir}/grits/server/requirements.txt",
    virtualenv   => 'grits',
  }

  exec { 'grits client setup':
    cwd => "${boxen::config::srcdir}/grits/client",
    path => "/bin:/usr/bin:${boxen::config::home}/nodenv/shims:${boxen::config::home}/nodenv/versions/v0.10/bin",
    command => "npm install; grunt";
  }

  file { "${boxen::config::home}/config/nginx/sites/grits.conf":
    ensure => link,
    target => "${boxen::config::srcdir}/grits/nginx.conf",
    notify  => Service['dev.nginx'];
  }

  file { "${boxen::config::home}/data/nginx/grits":
    ensure => link,
    target => "${boxen::config::srcdir}/grits/client";
  }
}