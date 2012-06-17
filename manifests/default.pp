include apt

class colognerb {
  exec { 'apt-get update': command => '/usr/bin/apt-get update' }

  package { "git-core": ensure => present }
  package { "nginx": ensure => present, require => Exec['apt-get update'] }

  file { "/etc/timezone": content => "Europe/Berlin" }
  file { "/etc/localtime": source => "/usr/share/zoneinfo/Europe/Berlin" }
  file { "/etc/ssh/sshd_config": source => "/vagrant/manifests/files/sshd_config" }

  service { "nginx": ensure => running, require => Package["nginx"] }

  file { "/etc/nginx/sites-enabled/default": ensure => absent, require => Package["nginx"] } 
  file { "/etc/nginx/sites-available/cologne.onruby.dev":
    ensure => link, 
    notify => Service["nginx"],
    require => Package["nginx"],
    target => "/vagrant/manifests/files/cologne.onruby.dev"
  }
  file { "/etc/nginx/sites-enabled/cologne.onruby.dev":
    ensure => link, 
    notify => Service["nginx"],
    require => Package["nginx"],
    target => "/etc/nginx/sites-available/cologne.onruby.dev"
  }
}

node "cologne.onruby.dev" {
  include colognerb
}
