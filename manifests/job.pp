# Define upstart::job
#
# Install upstart job
#
# == Parameters
#
#   [*present*]
#     Ensure whether job init file is present or absent.
#     Default value: 'present'
#   [*start_runlevel*]
#     Upstart job start runlevel
#     Default value: [2345]
#   [*stop_runlevel*]
#     Upstart job runlevel
#     Default value: [!2345]
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
  $ensure         = 'present',
  $description    = undef,
  $author         = undef,
  $emits          = undef,
  $start_runlevel = '[2345]',
  $stop_runlevel  = '[!2345]',
  $respawn        = false,
  $respawn_limit  = undef,
  $instance       = undef,
  $pid            = undef,
  $kill_timeout   = undef,
  $normal_exit    = undef,
  $console        = undef,
  $env            = undef,
  $umask          = undef,
  $nice           = undef,
  $limit          = undef,
  $chroot         = undef,
  $chdir          = undef,
  $pre_start      = undef,
  $post_start     = undef,
  $post_stop      = undef,
  $expect         = undef,
  $use_script     = false,
  $cmd            = ''
) {

  #File["/etc/init/${title}.conf"] ~> Service[$name]

  file { "/etc/init/${title}.conf":
    ensure  => $ensure,
    content => template('upstart/job.conf.erb'),
  }

  #service { $name:
  #  provider => 'upstart',
  #}

}
