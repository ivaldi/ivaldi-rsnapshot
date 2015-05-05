class rsnapshot::master::config inherits rsnapshot::master {
  concat { $rsnapshot::params::config_path:
    ensure  => present,
  }
  concat::fragment { 'rsnapshot_main':
    target  => $rsnapshot::params::config_path,
    content => template('rsnapshot/rsnapshot.conf.erb'),
    order   => '01',
  }
  $all_exclusions = concat($rsnapshot::params::builtin_exclusions, $exclusions)
  concat::fragment { 'rsnapshot_exclusions':
    target  => $rsnapshot::params::config_path,
    content => template('rsnapshot/exclusions.conf.erb'),
    order   => '10',
  }

  exec { 'generate rsnasphot private ssh key':
    command  => "/usr/bin/ssh-keygen -t rsa -b 2048 -f /root/.ssh/rsnapshot.rsa -N '' -C 'root@${::fqdn}'",
    creates  => '/root/.ssh/rsnapshot.rsa',
  }
}
