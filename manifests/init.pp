# == Class: icinga
#
# Install and configure a full Icinga monitoring system.
# This will collect all exported nagios_hosts and nagios_services.
#
# === Parameters
#
# [*ensure*]
#   Should Icinga be installed? Defaults to "present".
#
# [*ensure_enable*]
#   Should the Icinga service be enabled? Defaults to "true".
#
# [*ensure_running*]
#   Should the Icinga service be running? Defaults to "running".
#
# === Examples
#
#  class { icinga:
#  }
#
#  class { icinga:
#    ensure => present,
#    ensure_enable => true,
#    ensure_running => running,
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
class icinga (
  $ensure          = hiera('ensure', $icinga::params::ensure),
  $ensure_enable   = hiera('ensure_enable', $icinga::params::ensure_enable),
  $ensure_running  = hiera('ensure_running', $icinga::params::ensure_running),
) inherits icinga::params {

  include icinga::service

  # Hack for bug #3299 where nagios stuff is root:600
  file { '/etc/icinga/objects/':
    ensure  => directory,
    mode    => '0644',
    recurse => true,
  }

  file { '/etc/icinga/objects/puppet/':
    ensure  => directory,
    mode    => '0644',
    recurse => true,
    #purge   => true,
    #force   => true,
    require => File['/etc/icinga/objects/'],
  }

  Nagios_host <<| |>> {
    notify => [Service['icinga'], File['/etc/icinga/objects/puppet/']],
  }

  Nagios_service <<| |>> {
    notify => [Service['icinga'], File['/etc/icinga/objects/puppet/']],
  }

  Nagios_servicegroup <<| |>> {
    notify => [Service['icinga'], File['/etc/icinga/objects/puppet/']],
  }

  Nagios_command <<| |>> {
    notify => [Service['icinga'], File['/etc/icinga/objects/puppet/']],
  }

  icinga::objects::command { 'check_jabber':
    command => '$USER1$/check_jabber -H "$HOSTADDRESS$"'
  }

  icinga::objects::servicegroup { 'cert': }

  icinga::objects::command { 'check_ssl_cert_host':
    command => '$USER1$/check_ssl_cert -H "$ARG1$" -w 14 -c 7 -r /etc/ssl/certs/ca-certificates.crt',
  }

  icinga::objects::command { 'check_ssl_cert_proto':
    command => '$USER1$/check_ssl_cert -H "$ARG1$" -P "$ARG2$" -p "$ARG3$" -w 14 -c 7 -r /etc/ssl/certs/ca-certificates.crt',
  }

  icinga::objects::servicegroup { 'libs': }
  icinga::objects::servicegroup { 'kernel': }
  icinga::objects::servicegroup { 'packages': }
  icinga::objects::servicegroup { 'fs': }
  icinga::objects::servicegroup { 'disk': }

}
