class rsnapshot::master(
  $location_name,
) inherits rsnapshot::params {

  Class["${module_name}::master::install"] ->
  Class["${module_name}::master::config"]
  contain "${module_name}::master::install"
  contain "${module_name}::master::config"

  Rsnapshot::Master::Node_definition <<| to_location == $location_name |>> {
    require => Class['Rsnapshot::Master::Config']
  }

  @@rsnapshot::node::master_definition { $::fqdn:
    location_name => $location_name,
    sshpubkey     => $::sshpubkey_root,
  }
}
