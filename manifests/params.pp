class rsnapshot::params {
  case $::osfamily {
    'Debian': {
      $pkg = 'rsnapshot'
      $config_path = '/etc/rsnapshot.conf'
      $builtin_exclusions = ['dev', 'proc', 'sys', 'run', 'tmp']
    }
    default: {
      fail('Unsupported operating system')
    }
  }
  $snapshot_root = '/var/backups/rsnapshot'
  $options  = []
  $verbose  = '2'
  $loglevel = '3'
  $logfile  = '/var/log/rsnapshot.log'
  $retain = {
    'hourly' => '4',
    'daily'  => '7',
    'weekly' => '4',
  }
}
