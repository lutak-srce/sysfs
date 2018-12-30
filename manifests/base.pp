#
# = Class: sysfs::base
#
class sysfs::base {

  if $facts['systemd'] {

    concat { 'sysfs_systemd_tmpfiles':
      path    => "/etc/tmpfiles.d/sysfs.conf",
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Exec['sysfs_systemd_tmpfiles_create'],
    }

    exec { 'sysfs_systemd_tmpfiles_create':
      refreshonly => true,
      command     => '/bin/systemd-tmpfiles --create --prefix=/sys',
    }

    concat::fragment { 'sysfs_systemd_tmpfiles_header':
      target  => 'sysfs_systemd_tmpfiles',
      content => "# This file is being maintained by Puppet.\n",
      order   => '100',
    }

  } else {

    case $::operatingsystem {
      default: {}
      /CentOS|RedHat/: {
        class { 'sysfs::sysvinit':
          initd_source => 'puppet:///modules/sysfs/init.RedHat',
        }
      }
      'Ubuntu': {
        class { 'sysfs::sysvinit':
          initd_source => 'puppet:///modules/sysfs/init.Ubuntu',
        }
      }
    }
  }

}
