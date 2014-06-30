# == Class: icinga::package
#
# Install the Icinga monitoring daemon.
#
# === Parameters
#
# [*ensure*]
#   Should Icinga be installed? Defaults to "present".
#
# === Examples
#
#  class { icinga::package:
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
class icinga::package (
  $ensure = hiera('ensure', $icinga::params::ensure),
) inherits icinga::params {

  ensure_packages($icinga::params::icinga_package,
    {
    ensure  => $ensure,
    alias   => 'icinga',
    }
  )

  ensure_packages($icinga::params::nrpe_plugin_package,
    {
    ensure  => $ensure,
    alias   => 'nrpe-plugin',
    }
  )
}

