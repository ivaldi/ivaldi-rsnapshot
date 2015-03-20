define rsnapshot::master::node_definition(
    $ensure=present,
    $to_location,
    $sshdsakey,
    $sshrsakey,
    $ipaddress,
    $user='root') {

  if $user != 'root' {
    $extra_args = '+rsync_long_args=--rsync-path="sudo rsync"'
  } else {
    $extra_args = ''
  }

  file_line { "$name backups":
    ensure => $ensure,
    path   => '/etc/rsnapshot.conf',
    match  => "backup\t.*@$ipaddress:/\t$name/.*",
    line   => "backup\t$user@$ipaddress:/\t$name/\t$extra_args",
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
