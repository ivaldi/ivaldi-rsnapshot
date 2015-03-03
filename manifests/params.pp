class rsnapshot::params {
  case $::osfamily {
    'Debian': {
      $pkg = 'rsnapshot'
    }
    default: {
      fail('Unsupported operating system')
    }
  }
}
