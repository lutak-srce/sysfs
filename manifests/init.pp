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

  ### Input parameters validation
  validate_re($type, ['value', 'mode','owner'], 'Valid values are: value, mode, owner')

  # Parent purged directory
  include ::sysfs::base

  # The permanent change
  file { "/etc/sysfs.d/${title}.conf":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('sysfs/sysfs.erb'),
    notify  => Service['sysfsutils'],
  }
# "# ${comment}\n${title} = ${value}\n",

}
