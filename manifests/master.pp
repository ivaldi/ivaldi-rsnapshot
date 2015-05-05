class rsnapshot::master(
  $location_name,
  $exclusions    = [],
  $snapshot_root = $rsnapshot::params::snapshot_root,
  $retain        = $rsnapshot::params::retain,
  $options       = $rsnapshot::params::options,
  $verbose       = $rsnapshot::params::verbose,
  $loglevel_     = $rsnapshot::params::loglevel,
  $logfile       = $rsnapshot::params::logfile,
  $hourly_hour   = $rsnapshot::params::hourly_hour,
  $hourly_minute = $rsnapshot::params::hourly_minute,
  $daily_hour    = $rsnapshot::params::daily_hour,
  $daily_minute  = $rsnapshot::params::daily_minute,
  $weekly_hour    = $rsnapshot::params::weekly_hour,
  $weekly_minute  = $rsnapshot::params::weekly_minute,
  $weekly_weekday = $rsnapshot::params::weekly_weekday,
  $monthly_hour     = $rsnapshot::params::monthly_hour,
  $monthly_minute   = $rsnapshot::params::monthly_minute,
  $monthly_monthday = $rsnapshot::params::monthly_monthday,
) inherits rsnapshot::params {

  validate_absolute_path($snapshot_root)

  Class["${module_name}::master::install"] ->
  Class["${module_name}::master::config"] ->
  Class["${module_name}::master::cron"]
  contain "${module_name}::master::install"
  contain "${module_name}::master::config"
  contain "${module_name}::master::cron"

  Rsnapshot::Master::Node_definition <<| to_location == $location_name |>>

  @@rsnapshot::node::master_definition { $::fqdn:
    location_name => $location_name,
    sshpubkey     => $::sshpubkey_rsnapshot,
  }
}
