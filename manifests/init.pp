#
# = Define: sysfs
#
# Manage sysfs values.
#
define sysfs (
  $attribute,
  $value,
  $ensure  = present,
  $type    = 'value',
  $comment = undef,
) {

  include ::sysfs::base

  if $facts['systemd'] {

    concat::fragment { "sysfs_systemd_tmpfiles_${title}":
      target  => 'sysfs_systemd_tmpfiles',
      content => "# ${comment}\nw /sys/${attribute} - - - - ${value}\n",
      order   => '200',
    }

  } else {

    file { "/etc/sysfs.d/${title}.conf":
      ensure  => $ensure,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('sysfs/sysfs.erb'),
      notify  => Service['sysfsutils'],
    }
  }

}
