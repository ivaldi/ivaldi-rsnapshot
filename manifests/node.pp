class rsnapshot::node($to_location, $ensure=present, $user='root') {

  @@rsnapshot::master::node_definition { $fqdn:
    ensure      => $ensure,
    to_location => $to_location,
    ipaddress   => $::ipaddress,
    sshdsakey   => $::sshdsakey,
    sshrsakey   => $::sshrsakey,
    user        => $user,
  }

  user { $user:
    ensure     => $ensure,
    managehome => true,
  }

  Rsnapshot::Node::Master_definition <<| location_name == $to_location |>> {
    user    => $user,
    require => User[$user],
  }

  file_line { "$user sudo rsync":
    ensure => $ensure,
    path   => '/etc/sudoers',
    line   => "$user ALL= NOPASSWD: /usr/bin/rsync --server",
  }
}
