# == Class: icinga::host
#
# Install and configure an Icinga client: a NRPE enabled host.
# This will export several nagios_* ressources to be collected by the
# Icinga server.
#
# === Parameters
#
# None
#
# === Examples
#
#  class { icinga::host:
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
class icinga::host {
  include icinga::nrpe

  $ensure = present

  @@nagios_host { "host_${::fqdn}":
    ensure              => $ensure,
    address             => $::fqdn,
    host_name           => $::fqdn,
    alias               => $::fqdn,
    use                 => 'generic-host',
    target              => "/etc/icinga/objects/puppet/host_${::fqdn}.cfg",
  }

  icinga::objects::service { 'libs':
    command       => 'check_nrpe_1arg!check_libs',
    group         => 'libs',
  }

  if $::virtual != 'openvzve' {
    icinga::objects::service { 'kernel':
      command       => 'check_nrpe_1arg!check_running_kernel',
      group         => 'kernel',
    }
  }

  if $::osfamily == 'Debian' {
    icinga::objects::service { 'packages':
      command       => 'check_nrpe_1arg!check_packages',
      group         => 'packages',
    }

  $check_packages_ignore = hiera_array('icinga::host::check_packages_ignore', [])

    file { '/etc/nagios-plugins/obsolete-packages-ignore.d/puppet-icinga-ignores':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['nagios-plugins-contrib'],
      content => template('icinga/etc/nagios-plugins/obsolete-packages-ignore.d/puppet-icinga-ignores.erb'),
    }
  }

  icinga::objects::service { 'entropy':
    command       => 'check_nrpe_1arg!check_entropy',
  }

  if $::virtual != 'openvzve' {
    icinga::nrpe::command { 'check_ntp_peer':
      command_line => '/usr/lib/nagios/plugins/check_ntp_peer -H localhost -w 1 -c 2'
    }
    icinga::objects::service { 'ntp':
      command  => 'check_nrpe_1arg!check_ntp_peer',
    }
  }

  $a_mounts = split($::mounts, ',')
  $disk_limits = hiera('icinga::host::disk_limits', {})

  file { "${icinga::params::nrpe_d_folder}/disk.cfg":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[$icinga::params::nrpe_service],
    require => File[$icinga::params::nrpe_d_folder],
    content => template('icinga/etc/nagios/nrpe.d/disk.cfg.erb'),
  }
  icinga::objects::service_parametrized { $a_mounts:
    command => 'check_nrpe_1arg!check_disk_',
    group   => 'fs',
  }

  if $::virtual == 'physical' {
    $a_disks = split($::disks, ',')
    file { "${icinga::params::nrpe_d_folder}/smart.cfg":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Service[$icinga::params::nrpe_service],
      require => File[$icinga::params::nrpe_d_folder],
      content => template('icinga/etc/nagios/nrpe.d/smart.cfg.erb'),
    }
    icinga::objects::service_parametrized { $a_disks:
      command => 'check_nrpe_1arg!check_ide_smart_',
      group   => 'disk',
    }

    icinga::objects::service { 'sensors':
      command       => 'check_nrpe_1arg!check_sensors',
    }
  }

  $services = hiera('icinga::host::services', {})
  $services_k = keys($services)
  icinga::objects::service_generated { $services_k: config => $services; }

}
