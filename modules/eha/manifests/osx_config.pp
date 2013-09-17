class eha::osx_config {
  include dockutil
  include osx::global::expand_save_dialog
  include osx::finder::unhide_library
  include osx::disable_app_quarantine
  include osx::software_update
  include osx::finder

  boxen::osx_defaults {
    'Show all files':
      ensure => present,
      key    => 'AppleShowAllFiles',
      domain => 'com.apple.finder',
      value  => true,
      user   => $::boxen_user,
      notify => Exec['killall Finder'];
  
    'Show all filename extensions':
      ensure => present,
      key    => 'AppleShowAllExtensions',
      domain => 'NSGlobalDomain',
      value  => 'true',
      type   => 'bool',
      user   => $::boxen_user;

    'Show status bar':
      ensure => present,
      key    => 'ShowStatusBar',
      domain => 'com.apple.finder',
      value  => 'true',
      type   => 'bool',
      user   => $::boxen_user;

    'Allow text selection in Quick Look':
      ensure => present,
      key    => 'QLEnableTextSelection',
      domain => 'com.apple.finder',
      value  => 'true',
      type   => 'bool',
      user   => $::boxen_user;

    'Display full POSIX path as Finder window title':
      ensure => present,
      key    => '_FXShowPosixPathInTitle',
      domain => 'com.apple.finder',
      value  => 'true',
      type   => 'bool',
      user   => $::boxen_user;

    'Disable the warning when changing a file extension':
      ensure => present,
      key    => 'FXEnableExtensionChangeWarning',
      domain => 'com.apple.finder',
      value  => 'false',
      type   => 'bool',
      user   => $::boxen_user;

    'Avoid creating .DS_Store files on network volumes':
      ensure => present,
      key    => 'DSDontWriteNetworkStores',
      domain => 'com.apple.desktopservices',
      value  => 'true',
      type   => 'bool',
      user   => $::boxen_user;

   'Use list view in all Finder windows by default':
      ensure => present,
      key    => 'FXPreferredViewStyle',
      domain => 'com.apple.finder',
      value  => 'Nlsv',
      type   => 'string',
      user   => $::boxen_user;

    'Disable the warning before emptying the Trash':
      ensure => present,
      key    => 'com.apple.finder',
      domain => 'WarnOnEmptyTrash',
      value  => 'false',
      type   => 'bool',
      user   => $::boxen_user;
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

}