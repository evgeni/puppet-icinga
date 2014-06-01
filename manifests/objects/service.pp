# define: icinga::objects::service
#
# This definition is a wrapper around Puppet's nagios_service.
define icinga::objects::service($command = false, $group = false) {
  @@nagios_service { "service_${::fqdn}_${name}":
    ensure              => present,
    check_command       => $command,
    host_name           => $::fqdn,
    service_description => $name,
    servicegroups       => $group,
    use                 => 'generic-service',
    target              => "/etc/icinga/objects/puppet/services_${::fqdn}.cfg",
  }
}
