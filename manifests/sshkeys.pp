class rsnapshot::sshkeys inherits rsnapshot::node {
  case $::sshrsakey {
    "": {
      err("no sshrsakey on $::fqdn")
    }
    default: {
      @@sshkey { "${::hostname}.${::domain}-ssh-rsa":
        type         => ssh-rsa,
        host_aliases => [$sshkey_aliases],
        key          => $::sshrsakey,
        ensure       => present,
        tag          => $::fqdn,
      }
    }
  }

  case $::sshdsakey {
    "": {
      err("no sshdsakey on $::fqdn")
    }
    default: {
      @@sshkey { "${::hostname}.${::domain}-ssh-dsa":
        type         => ssh-dss,
        host_aliases => [$sshkey_aliases],
        key          => $::sshdsakey,
        ensure       => present,
        tag          => $::fqdn,
      }
    }
  }

  case $::sshecdsakey {
    "": {
      err("no sshecdsakey on $::fqdn")
    }
    default: {
      @@sshkey { "${::hostname}.${::domain}-ssh-ecdsa":
        type         => 'ecdsa-sha2-nistp256',
        host_aliases => [$sshkey_aliases],
        key          => $::sshecdsakey,
        ensure       => present,
        tag          => $::fqdn,
      }
    }
  }
}
