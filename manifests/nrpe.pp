# == Class: icinga::nrpe
#
# Install and configure an NRPE server.
#
# === Parameters
#
# None
#
# === Examples
#
#  class { icinga::nrpe:
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
class icinga::nrpe {
  include icinga::nrpe::package
  include icinga::nrpe::config
  include icinga::nrpe::service
}
