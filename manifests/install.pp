# http://www.weewx.com/docs/setup.htm
# http://www.weewx.com/docs/usersguide.htm#wee_config_fousb

# todo: bin/wee_config_fousb --set-interval=5

class weewx::install {

  file { "/usr/local/src":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
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
    command => "/bin/bash -c 'cd /usr/local/src/weewx-code && python setup.py install'",
    refreshonly => true,
    require => Class[ "weewx::prereqs" ],
  }

  file { "/home/weewx":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }
}
