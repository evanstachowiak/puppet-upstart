# Define upstart::job
#
# Install upstart job
#
# == Parameters
#
#   [*present*]
#     Ensure whether job init file is present or absent.
#     Default value: 'present'
#   [*cmd*]
#     Script command to execute on start/restart
#     Default value: ''
#   [*description*]
#     Upstart job description
#     Default value: ''
#   [*expect*]
#     Set whether upstart job will fork/daemonize/or stop
#     Default value: 'fork'
#   [*use_script*]
#     Script to run on job start/restart
#     Default value: 'false'
#
# == Examples
#
#   upstart::job { 'resque':
#     cmd         => 'cd /var/rails_app; env QUEUE=* bundle exec rake resque:work',
#     description => 'resque worker init job for rails app',
#     expect      => 'fork',
#   }
#
# == Requires:
#
#   class { upstart: }
#
define upstart::job (
  $ensure      = 'present',
  $cmd         = $upstart::cmd,
  $description = $upstart::description,
  $expect      = $upstart::expect,
  $use_script  = $upstart::use_script
) {

  Class['upstart'] -> Upstart::Job[$name]
  include upstart

  file { "/etc/init/${title}.conf":
    ensure  => $ensure,
    content => template('upstart/job.conf.erb'),
  }

}
