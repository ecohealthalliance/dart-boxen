class people::nicopresto {

  git::config::global {
    'user.name':
      value => 'Nico Preston';
    'user.email':
      value => 'nicopresto@gmail.com';
     'alias.st':  value => 'status';
     'alias.ci':  value => 'commit';
     'alias.co':  value => 'checkout';
     'alias.di':  value => 'diff';
     'alias.dc':  value => 'log -p';
     'color.ui':  value => 'true';
  }
  $home     = "/Users/${::boxen_user}"
  include projects::all

}
