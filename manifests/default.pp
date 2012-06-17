include apt

class rvmruby {
  $version = 'ruby-1.9.3-p125'

  rvm::define::version { $rvmruby::version:
    ensure => 'present',
    system => 'false'
  }

  rvm::define::user { 'vagrant': }
}

class onruby {
  rvm::define::gem { "bundler": 
    ruby_version => $rvmruby::version,
    user => 'vagrant',
    gemset => 'on_ruby',
    gem_version => "1.2.0.pre.1"
  }

  rvm::define::gemset { "on_ruby": 
    ruby_version => $rvmruby::version,
    user => 'vagrant'
  }

  exec { "git_clone_onruby":
      cwd => "/home/vagrant",
      user => "vagrant", 
      command => "/usr/bin/git clone git://github.com/phoet/on_ruby.git",
      creates => "/home/vagrant/on_ruby",
      require => Package["git-core"]
  }
}

node "cologne.onruby" {
  include rvmruby
  include nginx

  include onruby

  exec { 'apt-update': command => '/usr/bin/apt-get update' }
  Exec["apt-update"] -> Package <| |>

  package { "git-core": ensure => present }
  package { "vim":      ensure => present }

  user { "vagrant":     ensure => present }

  file { "/etc/timezone": content => "Europe/Berlin" }
  file { "/etc/localtime": source => "/usr/share/zoneinfo/Europe/Berlin" }
}
