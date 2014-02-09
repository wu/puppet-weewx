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
  package { 'python-dev':
    ensure => present,
  }
  package { 'python-pip':
    ensure => present,
  }
  package { 'pyephem':
    ensure => installed,
    provider => pip,
    require => Package[ 'python-dev' ],
  }

  # required to check out weewx from subversion
  package { 'subversion':
    ensure => installed,
  }

}
