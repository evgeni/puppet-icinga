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
    Debian: {
      $icinga_package      = 'icinga'
      $nrpe_plugin_package = 'nagios-nrpe-plugin'
      $nrpe_server_package = 'nagios-nrpe-server'
      $nrpe_service        = 'nagios-nrpe-server'
      $nrpe_d_folder       = '/etc/nagios/nrpe.d'
      $plugins_packages    = [
                              'nagios-plugins-basic',
                              'nagios-plugins-standard',
                              'nagios-plugins-contrib'
                              ]
      $lmsensors_package   = 'lm-sensors'
      $binutils_package    = 'binutils'
    }
    RedHat: {
      $icinga_package      = 'icinga'
      $nrpe_plugin_package = 'nagios-plugins-nrpe'
      $nrpe_server_package = 'nrpe'
      $nrpe_service        = 'nrpe'
      $nrpe_d_folder       = '/etc/nrpe.d'
      $plugins_packages    = [ ]
      $lmsensors_package   = 'lm_sensors'
      $binutils_package    = 'binutils'
    }
    default: {
      fail('This module only supports Debian-based systems')
    }
  }

  $ensure              = present
  $ensure_running      = running
  $ensure_enable       = true
  $allowed_hosts       = ['127.0.0.1']
}
