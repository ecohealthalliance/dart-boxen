require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include nginx

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  include nodejs::v0_4
  include nodejs::v0_6
  include nodejs::v0_8
  include nodejs::v0_10

  # default ruby versions
  include ruby::1_8_7
  include ruby::1_9_2
  include ruby::1_9_3
  include ruby::2_0_0

  include chrome
  include firefox
  include dockutil
  include dropbox
  include emacs
  include mongodb
  include osx::global::expand_save_dialog
  include osx::finder::unhide_library
  include osx::disable_app_quarantine
  include osx::software_update
  include python
  include python::virtualenvwrapper
  include skype
  include evernote
  include libreoffice
  include wget
  include virtualbox
  include sublime_text_2
  sublime_text_2::package { 
    'Emmet':
      source => 'sergeche/emmet-sublime';
    'CoffeeScript':
      source => 'Xavura/CoffeeScript-Sublime-Plugin';
  }
  git::config::global {
    'color.ui': value => 'true';
  }
  class { 'nodejs::global': version => 'v0.10.13' }
  nodejs::module { 'coffee-script': node_version => 'v0.10.13' }
  nodejs::module { 'jade': node_version => 'v0.10.13' }
  nodejs::module { 'stylus': node_version => 'v0.10.13' }
  nodejs::module { 'grunt-cli': node_version => 'v0.10.13' }
  nodejs::module { 'docpad': node_version => 'v0.10.13' }

  include osx::finder
  boxen::osx_defaults { 'Show all files':
    user   => $::boxen_user,
    key    => 'AppleShowAllFiles',
    domain => 'com.apple.finder',
    value  => true,
    notify => Exec['killall Finder'];
  }

  package { 'R':
    ensure => installed;
  }

  dockutil::item {
    'Add Terminal':
      item     => "/Applications/Utilities/Terminal.app",
      label    => "Terminal",
      action   => "add",
      position => 2;

    'Add Chrome':
      item     => "/Applications/Google Chrome.app",
      label    => "Chrome",
      action   => "add",
      position => 3,
      require  => Class["chrome"];

    'Remove Launchpad':
      item    => "/Applications/Launchpad.app",
      label   => "Launchpad",
      action  => "remove";

    'Remove Mail':
      item => "/Applications/Mail.app",
      label   => "Mail",
      action => "remove";

    'Remove Contacts':
      item => "/Applications/Contacts.app",
      label   => "Contacts",
      action => "remove";

    'Remove Calendar':
      item => "/Applications/Calendar.app",
      label   => "Calendar",
      action => "remove";

    'Remove Messages':
      item => "/Applications/Messages.app",
      label   => "Messages",
      action => "remove";

    'Remove Reminders':
      item => "/Applications/Reminders.app",
      label   => "Reminders",
      action => "remove";

    'Remove Notes':
      item => "/Applications/Notes.app",
      label   => "Notes",
      action => "remove";

    'Remove FaceTime':
      item => "/Applications/FaceTime.app",
      label   => "FaceTime",
      action => "remove";

    'Remove Photo Booth':
      item => "/Applications/Photo Booth.app",
      label   => "Photo Booth",
      action => "remove";

    'Remove iTunes':
      item => "/Applications/iTunes.app",
      label   => "iTunes",
      action => "remove";

    'Remove iPhoto':
      item => "/Applications/iPhoto.app",
      label => "iPhoto",
      action => "remove";

    'Remove App Store':
      item => "/Applications/App Store.app",
      label   => "App Store",
      action => "remove";  
  }

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}
