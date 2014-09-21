define rsnapshot::master::node_definition($to_location, $sshdsakey, $sshrsakey, $ipaddress) {
  file_line { "$name backups":
    ensure => present,
    path   => '/etc/rsnapshot.conf',
    line   => "backup\troot@$name:/\t$name/",
  }

  sshkey { "${name}_dsa":
    type         => 'dsa',
    key          => $sshdsakey,
    host_aliases => [$name, $ipaddress],
  }
  sshkey { "${name}_rsa":
    type         => 'rsa',
    key          => $sshrsakey,
    host_aliases => [$name, $ipaddress],
  }
}
