class rsnapshot::node($to_location, $ensure=present, $user='root') {

  @@rsnapshot::master::node_definition { $fqdn:
    ensure      => $ensure,
    to_location => $to_location,
    ipaddress   => $::ipaddress,
    sshdsakey   => $::sshdsakey,
    sshrsakey   => $::sshrsakey,
    user        => $user,
  }

  Rsnapshot::Node::Master_definition <<| location_name == $to_location |>> {
    user => $user,
  }
}
