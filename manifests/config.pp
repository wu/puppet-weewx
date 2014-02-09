class weewx::config {

  file { "/home/weewx/weewx.conf":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 644,
    content => template('weewx/weewx.conf'),
    require => Class[ "weewx::install" ],
  }

}
