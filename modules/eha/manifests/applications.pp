class eha::applications {
  include chrome
  include firefox
  include dropbox
  include emacs
  include skype
  include evernote
  include libreoffice
  include virtualbox
  include sublime_text_2
  sublime_text_2::package { 
    'Emmet':
      source => 'sergeche/emmet-sublime';
    'CoffeeScript':
      source => 'Xavura/CoffeeScript-Sublime-Plugin';
  }

}
