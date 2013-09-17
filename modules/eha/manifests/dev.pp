class eha::dev {
  include mongodb
  include python
  include python::virtualenvwrapper
  include wget
  git::config::global {
    'color.ui': value => 'true';
  }
  class { 'nodejs::global': version => 'v0.10.13' }
  include eha::node_modules
}