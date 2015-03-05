define rsnapshot::master::exclusion() {
  include rsnapshot::params
  file_line { "exclude_${name}":
    ensure  => present,
    path    => $rsnapshot::params::config_path,
    line => "exclude\t${name}",
  }
}
