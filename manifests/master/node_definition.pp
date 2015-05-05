define rsnapshot::master::node_definition(
  $ensure = present,
  $to_location,
  $identifier,
  $ipaddress,
  $backup = {},
) {

  concat::fragment { "rsnapshot_node_${name}":
    target  => $rsnapshot::params::config_path,
    content => template('rsnapshot/rsnapshot_node.conf.erb'),
    order   => '50',
  }
}
