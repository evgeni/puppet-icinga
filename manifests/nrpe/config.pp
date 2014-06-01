# == Class: icinga::nrpe::config
#
# Configure the NRPE server.
#
# === Parameters
#
# [*ensure*]
#   Should the config files be installed? Defaults to "present".
#
# [*allowed_hosts*]
#   Which machines should be allowed to access our NRPE server.
#
# === Examples
#
#  class { icinga::nrpe::config:
#  }
#
# === Authors
#
# Evgeni Golov <evgeni@golov.de>
#
# === Copyright
#
# Copyright 2014 Evgeni Golov, unless otherwise noted.
#
class icinga::nrpe::config (
  $allowed_hosts = hiera('icinga::nrpe::allowed_hosts', $icinga::params::allowed_hosts),
  $ensure = hiera('ensure', $icinga::params::ensure)
) inherits icinga::params {

  $allowed_hosts_string = join($allowed_hosts, ',')

  file { '/etc/nagios/':
    ensure  => directory,
    mode    => '0644',
    require => Package['nagios-nrpe-server'],
  }

  augeas { 'nrpe.cfg_allowed_hosts':
    context => '/files/etc/nagios/nrpe.cfg',
    changes => [
      "set allowed_hosts ${allowed_hosts_string}",
    ],
    notify  => Service['nagios-nrpe-server'],
    require => File['/etc/nagios/'],
  }

  file { '/etc/nagios/nrpe.d/':
    ensure  => directory,
    mode    => '0644',
    recurse => true,
    source  => 'puppet:///modules/icinga/etc/nagios/nrpe.d/',
    notify  => Service['nagios-nrpe-server'],
    require => File['/etc/nagios/'],
  }

  file { '/etc/sudoers.d/':
    ensure  => directory,
    mode    => '0644',
  }

  file { '/etc/sudoers.d/icinga':
    ensure  => $ensure,
    source  => 'puppet:///modules/icinga/etc/sudoers.d/icinga',
    notify  => Service['nagios-nrpe-server'],
    require => File['/etc/sudoers.d/'],
  }

}
