class nfs::client::debian::service {

  service { 'rpcbind':
    ensure    => running,
    enable    => true,
    hasstatus => false,
  }

  # See https://bugs.debian.org/858274#10 why idmapd is not needed
  # on NFSv4 clients running newer Debian releases
  if $nfs::client::debian::nfs_v4 and versioncmp($facts['os']['release']['major'], '9') < 0 {
    service { 'idmapd':
      ensure    => running,
      enable    => true,
      name      => 'nfs-common',
      subscribe => Augeas['/etc/idmapd.conf', '/etc/default/nfs-common'],
    }
  }
}
