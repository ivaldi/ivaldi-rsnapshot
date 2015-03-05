class rsnapshot::master::config inherits rsnapshot::master {
  File_line {
    ensure  => present,
    path    => '/etc/rsnapshot.conf',
  }

  $builtin_exclusions = ['dev', 'proc', 'sys', 'run', 'tmp']
  rsnapshot::master::exclusion { [$builtin_exclusions]: }
  rsnapshot::master::exclusion { [$exclusions]: }

  file_line { 'snapshot_root':
    match   => "^snapshot_root\t",
    line    => "snapshot_root\t/var/backups/rsnapshot/",
  }

  exec { 'generate private ssh key':
    command  => "/usr/bin/ssh-keygen -f /root/.ssh/id_rsa -N '' -C 'root@${::fqdn}'",
    creates  => '/root/.ssh/id_rsa',
  }

  file_line { 'cmd_ssh':
    match => "cmd_ssh\t",
    line  => "cmd_ssh\t/usr/bin/ssh",
  }

  file_line { 'link_dest':
    match => "link_dest\t",
    line  => "link_dest\t1",
  }

  file_line { 'no_localhost_home':
    match => "backup\t\/home\/\t\tlocalhost\/",
    line  => "#backup\t/home/\t\tlocalhost/"
  }

  file_line { 'no_localhost_etc':
    match => "backup\t\/etc\/\t\tlocalhost\/",
    line  => "#backup\t/etc/\t\tlocalhost/"
  }

  file_line { 'no_localhost_usr_local':
    match => "backup\t\/usr\/local\/\tlocalhost\/",
    line  => "#backup\t/usr/local/\tlocalhost/"
  }

  file_line { 'retain_hourly':
    match => "retain\t\thourly\t",
    line  => "retain\t\thourly\t4",
  }

  cron { 'rsnapshot hourly':
    user    => root,
    hour    => '*/6',
    minute  => 0,
    command => 'rsnapshot hourly'
  }

  cron { 'rsnapshot daily':
    user    => root,
    hour    => 4,
    minute  => 0,
    command => 'rsnapshot daily'
  }

  cron { 'rsnapshot weekly':
    user    => root,
    hour    => 2,
    minute  => 0,
    weekday => 0,
    command => 'rsnapshot weekly'
  }
}
