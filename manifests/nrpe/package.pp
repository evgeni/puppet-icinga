# == Class: icinga::nrpe::package
#
# Install the NRPE server.
#
# === Parameters
#
# [*ensure*]
#   Should the NRPE server be installed? Defaults to "present".
#
# === Examples
#
#  class { icinga::nrpe::package:
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
class icinga::nrpe::package (
  $ensure = hiera('ensure', $icinga::params::ensure),
) inherits icinga::params {

  package { $icinga::params::nrpe_server_package:
    ensure  => $ensure,
    alias   => 'nrpe-server',
  }

  package {
    [ 'nagios-plugins-basic',
      'nagios-plugins-standard',
      'nagios-plugins-contrib' ] :
    ensure  => $ensure,
  }

}

