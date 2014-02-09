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
