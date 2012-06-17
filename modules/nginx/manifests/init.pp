class nginx {
  file { "/etc/nginx/sites-enabled/default": 
    ensure => absent, 
    require => Package["nginx"] 
  }

  file { "/etc/nginx/sites-available/cologne.onruby.dev":
    ensure => present, 
    notify => Service["nginx"],
    require => Package["nginx"],
    content => template("nginx/cologne.onruby.dev")
  }

  file { "/etc/nginx/sites-enabled/cologne.onruby.dev":
    ensure => link, 
    notify => Service["nginx"],
    require => Package["nginx"],
    target => "/etc/nginx/sites-available/cologne.onruby.dev"
  }

  service { "nginx": 
    ensure => running, 
    require => Package["nginx"] 
  }

  package { "nginx": 
    ensure => present 
  }
}

