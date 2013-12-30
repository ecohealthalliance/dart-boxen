class eha::dev {
  include mongodb
  include python
  include python::virtualenvwrapper
  include java
  include wget
  git::config::global {
    'color.ui': value => 'true';
  }
  class { 'nodejs::global': version => 'v0.10.21' }
  include eha::node_modules

  package { 'R':
    ensure => installed;
  }

  exec { 'meteor install':
    command => "curl https://install.meteor.com | /bin/sh; ln -s ~/.meteor/tools/latest/launch-meteor ${boxen::config::home}/bin/meteor"
  }


}