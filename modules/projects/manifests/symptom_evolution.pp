class projects::symptom_evolution {
  boxen::project { 'symptom_evolution':
    source => 'ecohealthalliance/symptom_evolution',
    notify => Exec['Set up docpad for symptom_evolution'];
  }

  exec { 'Set up docpad for symptom_evolution':
    cwd => "${boxen::config::srcdir}/symptom_evolution",
    path => "/bin:/usr/bin:${boxen::config::home}/nodenv/shims:${boxen::config::home}/nodenv/versions/v0.10/bin",
    command => "docpad update";
  }
}