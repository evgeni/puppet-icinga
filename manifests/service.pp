# == Class: icinga::service
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
class icinga::service inherits icinga {

  service { 'icinga':
    ensure     => $icinga::ensure_running,
    enable     => $icinga::ensure_enable,
    hasrestart => true,
    restart    => 'service icinga reload',
    hasstatus  => true,
    require    => Package['icinga'],
  }

}

