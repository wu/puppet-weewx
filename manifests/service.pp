class weewx::service {

  file { "/etc/init.d/weewx":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 555,
    source => "puppet:///modules/weewx/weewx.debian",
    require => Class[ "weewx::install" ],
  }

  service { "weewx":
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    enable => true,
    require => [ Class[ "weewx::install" ], File[ "/etc/init.d/weewx" ] ],
  }

  file { '/etc/rc0.d/K01weewx':
    ensure => 'link',
    target => '../init.d/weewx',
  }
  file { '/etc/rc1.d/K01weewx':
    ensure => 'link',
    target => '../init.d/weewx',
  }
  file { '/etc/rc2.d/S02weewx':
    ensure => 'link',
    target => '../init.d/weewx',
  }
  file { '/etc/rc3.d/S02weewx':
    ensure => 'link',
    target => '../init.d/weewx',
  }
  file { '/etc/rc4.d/S02weewx':
    ensure => 'link',
    target => '../init.d/weewx',
  }
  file { '/etc/rc5.d/S02weewx':
    ensure => 'link',
    target => '../init.d/weewx',
  }
  file { '/etc/rc6.d/K01weewx':
    ensure => 'link',
    target => '../init.d/weewx',
  }


}
