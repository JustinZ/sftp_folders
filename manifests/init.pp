# Class: sftp_folders
#
# This module manages sftp_folders
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#


class sftp_folders(
    $dir_list = undef,
    $ensure = 'directory',
    $owner = undef,
    $group = 'root',
    $mode = '0650',

  ) {
Notify { "Node DRBD status is $::check_drbd_master"}
keys($dir_list).each | String $client_env |  
{
  $dir_list[$client_env][directory].each|String $dir_name |
  {
    file {$dir_name :
      path => $dir_name,
      ensure => $ensure,
      owner => $dir_list[$client_env][owner],
      group => $group,
      mode => $mode,    
  }
 
  $parent = regsubst($dir_name, '/[^/]*/?$', '')
  if ($parent != $dir_name) and ($parent != '') {
    exec { "create parent directory $parent for $dir_name":
      # mode? uid/gid?  you decide...
      command => "/bin/mkdir -p $parent",
      creates => "$parent",
      before => File[$dir_name]
    }
   }
  }
 }
}

