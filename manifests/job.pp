define upstart::job (
  $ensure      = 'present',
  $description = '',
  $fork=false,
  $cmd='',
  $use_script=false
) {

  Class['upstart'] -> Upstart::Job[$name]
  include upstart

  file { "/etc/init/${title}.conf":
    ensure  => $ensure,
    content => template('upstart/job.conf.erb'),
  }

}
