# == Class: icinga::params
#
# Default parameters for the icinga class.
#
# === Authors
#
# Evgeni Golov <evgeni@golov.de>
#
# === Copyright
#
# Copyright 2014 Evgeni Golov, unless otherwise noted.
#
class icinga::params {

  case $::osfamily {
    Debian: { }
    default: {
      fail('This module only supports Debian-based systems')
    }
  }

  $ensure              = present
  $ensure_running      = running
  $ensure_enable       = true
  $allowed_hosts       = ['127.0.0.1']
}
