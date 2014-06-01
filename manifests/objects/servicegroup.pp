# define: icinga::objects::servicegroup
#
# This definition is a wrapper around Puppet's nagios_servicegroup.
define icinga::objects::servicegroup() {
  @@nagios_servicegroup { "servicegroup_${name}":
    ensure              => present,
    servicegroup_name   => $name,
    target              => "/etc/icinga/objects/puppet/servicegroup_${name}.cfg",
  }
}
