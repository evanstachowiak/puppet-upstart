class upstart inherits upstart::params {

  package { 'upstart':
    ensure => installed,
  }

}
