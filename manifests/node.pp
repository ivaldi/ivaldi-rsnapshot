class rsnapshot::node($to_location) {

  @@rsnapshot::master::node_definition { $fqdn:
    to_location => $to_location,
    ipaddress   => $::ipaddress,
    sshdsakey   => $::sshdsakey,
    sshrsakey   => $::sshrsakey,
  }

  Rsnapshot::Node::Master_definition <<| location_name == $to_location |>>
}
