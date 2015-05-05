class rsnapshot::master(
  $location_name,
  $exclusions    = [],
  $snapshot_root = $rsnapshot::params::snapshot_root,
  $retain        = $rsnapshot::params::retain,
  $options       = $rsnapshot::params::options,
  $verbose       = $rsnapshot::params::verbose,
  $loglevel_     = $rsnapshot::params::loglevel,
  $logfile       = $rsnapshot::params::logfile,
) inherits rsnapshot::params {

  validate_absolute_path($snapshot_root)

  Class["${module_name}::master::install"] ->
  Class["${module_name}::master::config"]
  contain "${module_name}::master::install"
  contain "${module_name}::master::config"

  Rsnapshot::Master::Node_definition <<| to_location == $location_name |>>

  @@rsnapshot::node::master_definition { $::fqdn:
    location_name => $location_name,
    sshpubkey     => $::sshpubkey_rsnapshot,
  }
}
