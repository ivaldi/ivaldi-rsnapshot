class rsnapshot::params {
  case $::osfamily {
    'Debian': {
      $pkg = 'rsnapshot'
      $config_path = '/etc/rsnapshot.conf'
    }
    default: {
      fail('Unsupported operating system')
    }
  }
}
