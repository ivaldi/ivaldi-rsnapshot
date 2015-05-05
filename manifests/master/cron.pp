class rsnapshot::master::cron inherits rsnapshot::master {
  cron { 'rsnapshot hourly':
    user    => 'root',
    hour    => $hourly_hour,
    minute  => $hourly_minute,
    command => 'rsnapshot hourly'
  }
  cron { 'rsnapshot daily':
    user    => 'root',
    hour    => $daily_hour,
    minute  => $daily_minute,
    command => 'rsnapshot daily'
  }
  cron { 'rsnapshot weekly':
    user    => 'root',
    hour    => $weekly_hour,
    minute  => $weekly_minute,
    weekday => $weekly_weekday,
    command => 'rsnapshot weekly'
  }
  cron { 'rsnapshot monthly':
    user    => 'root',
    hour    => $monthly_hour,
    minute  => $monthly_minute,
    monthday => $monthly_monthday,
    command => 'rsnapshot monthly'
  }
}
