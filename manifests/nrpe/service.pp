# == Class: icinga::nrpe::service
#
# Installs the icinga package.
#
# === Authors
#
# Evgeni Golov <evgeni@golov.de>
#
# === Copyright
#
# Copyright 2014 Evgeni Golov, unless otherwise noted.
#
class icinga::nrpe::service (
  $ensure_running = hiera('ensure_running', $icinga::params::ensure_running),
  $ensure_enable  = hiera('ensure_enable', $icinga::params::ensure_enable),
) inherits icinga::params {

  service { $icinga::params::nrpe_service:
    ensure     => $ensure_running,
    enable     => $ensure_enable,
    hasrestart => true,
    restart    => "service ${icinga::params::nrpe_service} reload",
    hasstatus  => true,
    require    => Class['icinga::nrpe::config'],
  }

}
