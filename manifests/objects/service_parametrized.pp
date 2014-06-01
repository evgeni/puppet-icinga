# define: icinga::objects::service_parametrized
#
# This definition is a wrapper around icinga::objects::service.
# It allows definitions of services which need the name of the service
# as part of the check command, like filesystem and SMART checks.
define icinga::objects::service_parametrized($command = false, $group = false) {
  icinga::objects::service { $name:
    command => "${command}${name}",
    group   => $group,
  }
}
