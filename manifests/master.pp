class rsnapshot::master($location_name) {

  package { 'rsnapshot': }


  Rsnapshot::Master::Node_definition <<| to_location == $location_name |>> {
    require => Class['Rsnapshot::Master::Config']
  }

  include rsnapshot::master::config

  @@rsnapshot::node::master_definition { $fqdn:
    location_name => $location_name,
    sshpubkey     => $::sshpubkey_root,
  }
}
