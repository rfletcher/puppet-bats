# == Class: bats
#
# Installs Bats
#
# === Parameters
#
# [*prefix*]
#   Installation prefix
#
# === Examples
#
#  class { 'bats':
#    prefix => '/usr/local',
#  }
#
# === Authors
#
# Rick Fletcher <fletch@pobox.com>
#
# === Copyright
#
# Copyright 2014 Rick Fletcher
#
class bats (
  $prefix = '/usr/local',
) {
  $source_dir = '/usr/local/src/bats'

  vcsrepo { $source_dir:
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/sstephenson/bats.git',
  } ->

  exec { "install.sh ${prefix}":
    cwd     => $source_dir,
    creates => "${prefix}/bin/bats",
    path    => [$source_dir, '/usr/bin', '/bin'],
    require => Vcsrepo[$source_dir],
  }
}
