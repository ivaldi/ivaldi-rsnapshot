define rsnapshot::node::master_definition($location_name, $sshpubkey, $user) {

  if ($sshpubkey !~ /^(ssh-...) ([^ ]*)/) {
    err("Can't parse key from root@$name")
    notify { "Can't parse key from root@$name. Skipping": }
  } else {
    $keytype = $1
    $keyvalue = $2
    ssh_authorized_key { "root@$name":
      ensure => present,
      type => $keytype,
      key => $keyvalue,
      user => $user,
    }
  }
}
