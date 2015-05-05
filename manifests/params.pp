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
    'hourly'  => '6',
    'daily'   => '7',
    'weekly'  => '4',
    'monthly' => '3',
  }
  $hourly_hour   = '*/4'
  $hourly_minute = '0'
  $daily_hour    = '23'
  $daily_minute  = '50'
  $weekly_hour    = '23'
  $weekly_minute  = '40'
  $weekly_weekday = '6'
  $monthly_hour     = '23'
  $monthly_minute   = '30'
  $monthly_monthday = '1'
}
