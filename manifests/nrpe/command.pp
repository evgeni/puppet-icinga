# define: icinga::nrpe::command
#
# This definition creates NRPE command snipets and places them (by default)
# in a file in the nrpe.d directory.
# That can be used to install NRPE commands from your manifests.
define icinga::nrpe::command(
  $command_line,
  $command_name = $name,
  $ensure       = present,
  $group        = 'root',
  $mode         = '0644',
  $owner        = 'root',
  $target       = "${icinga::params::nrpe_d_folder}/${name}.cfg",
  ) {
  file { $target:
    ensure  => $ensure,
    path    => $target,
    group   => $group,
    mode    => $mode,
    owner   => $owner,
    content => template('icinga/etc/nagios/nrpe.d/command.cfg.erb'),
    notify  => Service[$icinga::params::nrpe_service],
    require => File[$icinga::params::nrpe_d_folder],
  }
}
