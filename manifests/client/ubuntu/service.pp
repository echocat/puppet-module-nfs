class nfs::client::ubuntu::service {

  service { 'rpcbind':
    ensure    => running,
    enable    => true,
    hasstatus => false,
    provider  => 'init',
  }

  # From Ubuntu 15.04 and onwards, the idmapd service does NOT have an init
  # script, as its apart of the nfs-server service.
  case $::lsbdistrelease {
    '10.04','12.04','14.04': {
      if $nfs::client::ubuntu::nfs_v4 {
        service { 'idmapd':
          ensure    => running,
          enable    => true,
          subscribe => Augeas['/etc/idmapd.conf', '/etc/default/nfs-common'],
        }
      } else {
        service { 'idmapd':
          ensure => stopped,
          enable => false,
        }
      }
    }
    default: { }
  }
}
