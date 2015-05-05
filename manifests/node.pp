class rsnapshot::node(
  $to_location,
  $ensure     = present,
  $identifier = $::fqdn,
  $ipaddress  = $::ipaddress,
  $backup     = {},
) {

  @@rsnapshot::master::node_definition { $identifier:
    ensure      => $ensure,
    to_location => $to_location,
    identifier  => $identifier,
    ipaddress   => $ipaddress,
    backup      => $backup,
  }

  Rsnapshot::Node::Master_definition <<| location_name == $to_location |>>
}
