# define: icinga::objects::command
#
# This definition is a wrapper around Puppet's nagios_command.
define icinga::objects::command($command = false, $group = false) {
  @@nagios_command { "command_${name}":
    ensure              => present,
    command_name        => $name,
    command_line        => $command,
    target              => "/etc/icinga/objects/puppet/command_${name}.cfg",
  }
}
