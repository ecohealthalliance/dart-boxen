class people::nicopresto {
  include libreoffice
  
  git::config::global {
    'user.name':
      value => 'Nico Preston';
    'user.email':
      value => 'nicopresto@gmail.com';
  }
  $home     = "/Users/${::boxen_user}"
  include projects::all

}
