#
# = Class: sysfs::base
#
# Install sysfsutils
#
class sysfs::base {

  File {
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['sysfsutils'],
  }

  package { 'sysfsutils':
    ensure => present,
  }

  file { '/etc/sysfs.conf':
    source  => 'puppet:///modules/sysfs/sysfs.conf',
  }

  file { '/etc/sysfs.d':
    ensure  => directory,
    recurse => true,
    purge   => true,
  }

  case $::operatingsystem {
    default: {}
    /CentOS|RedHat/: {
      file { '/etc/init.d/sysfsutils':
        mode   => '0755',
        source => 'puppet:///modules/sysfs/init.RedHat',
        before => Service['sysfsutils'],
      }
    }
    'Ubuntu': {
      file { '/etc/init.d/sysfsutils':
        mode   => '0755',
        source => 'puppet:///modules/sysfs/init.Ubuntu',
        before => Service['sysfsutils'],
      }
    }
  }

  service { 'sysfsutils':
    ensure => running,
    enable => true,
  }

}
