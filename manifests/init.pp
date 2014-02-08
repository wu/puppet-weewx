class weewx::prereqs {
  # required packages
  package { [ 'python-configobj', 'python-cheetah', 'python-imaging' ]:
    ensure => present,
  }

  # required if hardware is serial or USB
  package { 'python-serial':
    ensure => present,
  }
  package { 'python-usb':
    ensure => present,
  }

  # required if using MySQL:
  package { [ 'mysql-client', 'python-mysqldb' ]:
    ensure => present,
  }

  # optional for extended almanac information
  #package { 'python-dev':
  #  ensure => present,
  #}
  package { 'python-pip':
    ensure => present,
  }
  package { 'pyephem':
    ensure => installed,
    provider => pip,
  }
}

class weewx::install {
  # todo: bin/wee_config_fousb --set-interval=5

  file { "/usr/local/src":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }

  package { 'subversion':
    ensure => installed,
  }

  vcsrepo { "/usr/local/src/weewx-code":
    ensure => present,
    provider => svn,
    source => "svn://svn.code.sf.net/p/weewx/code/trunk",
    owner => root,
    group => root,
    require => [ Package[ 'subversion' ], File[ '/usr/local/src' ] ],
    notify => Exec['install-weewx'],
  }

  exec { "install-weewx":
    command => "bash -c 'cd /usr/local/src/weewx-code && python setup.py install'",
    refreshonly => true,
    require => Class[ "weewx::prereeqs" ],
  }

  file { "/home/weewx":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }

}

class weewx::config {
  # http://www.daftlogic.com/sandbox-google-maps-find-altitude.htm
  # $location  = "Hood River, Oregon"
  # $latitude  = "45.686"
  # $longitude = "-121.566"
  # $altitude  = "700, foot"
  # $station_type = "FineOffsetUSB"
  # $model        = "WS2080"
  # $station_url = "http://geekfarm.org/weather/"
  # $rsync_server = "geekfarm.org"
  # $rsync_user = "username"
  # $rsync_path = "/path/to/public_html/weather/"

  #############################################################################
  file { "/home/weewx/weewx.conf":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 644,
    content => template('weewx/weewx.conf'),
    require => Class[ "weewx::install" ],
  }

}

class weewx::webserver {
  package { 'apache2':
    ensure => present,
  }
  file { "/etc/apache2/conf.d/weewx.conf":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/weewx/apache2-weewx.conf",
    require => Package["apache2"],
  }
  service { "apache2":
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    enable => true,
    require => [ Class["weewx::install"], Package["apache2"] ],
  }
}


class weewx {
  # http://www.weewx.com/docs/setup.htm
  # http://www.weewx.com/docs/usersguide.htm#wee_config_fousb

  include weewx::prereqs, weewx::install, weewx::config, weewx::webserver
}
