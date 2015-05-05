define rsnapshot::master::exclusion() {
  include rsnapshot::params
  concat::fragment { 'rsnapshot_exclusions':
    target  => $rsnapshot::params::config_path,
    content => template('rsnapshot/rsnapshot.conf.erb'),
    order   => '10',
  }
}
