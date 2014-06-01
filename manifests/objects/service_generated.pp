# define: icinga::objects::service_generated
#
# This definition creates a icinga::objects::service from a hash,
# which is typically received from a YAML via hiera.
# It should not be used directly. Use icinga::objects::service instead.

define icinga::objects::service_generated($config){
  icinga::objects::service { $name:
    command => $config[$name]['command'],
  }
}
