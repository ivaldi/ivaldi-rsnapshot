define rsnapshot::master::node_definition(
    $ensure=present,
    $to_location,
    $sshdsakey,
    $sshrsakey,
    $ipaddress,
    $user='root') {

  file_line { "$name backups":
    ensure => $ensure,
    path   => '/etc/rsnapshot.conf',
    line   => "backup\t$user@$ipaddress:/\t$name/",
  }

  sshkey { "${name}_dsa":
    ensure       => $ensure,
    type         => 'dsa',
    key          => $sshdsakey,
    host_aliases => [$name, $ipaddress],
  }
  sshkey { "${name}_rsa":
    ensure       => $ensure,
    type         => 'rsa',
    key          => $sshrsakey,
    host_aliases => [$name, $ipaddress],
  }
}
