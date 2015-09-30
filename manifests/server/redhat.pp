class nfs::server::redhat(
  $nfs_v4              = false,
  $nfs_v4_idmap_domain = undef,
  $mountd_port         = undef,
  $mountd_threads      = 1
) {
  if ($::operatingsystemmajrelease == defined) and ($::operatingsystemmajrelease =~ /^7/) {
    $service_name = 'nfs-server'
  } else {
    $service_name = 'nfs'
  }

  if !defined(Class['nfs::client::redhat']) {
    class{ 'nfs::client::redhat':
      nfs_v4              => $nfs_v4,
      nfs_v4_idmap_domain => $nfs_v4_idmap_domain,
    }
  }

  if ($mountd_port != undef){
    shellvar { 'rpc-mount-options':
      ensure   => present,
      target   => '/etc/sysconfig/nfs',
      variable => 'MOUNTD_PORT',
      value    => $mountd_port,
    }

    if $nfs::server::service_manage {
      Shellvar['rpc-mount-options'] ~> Service[$service_name]
    }
  }

  include nfs::server::redhat::install, nfs::server::redhat::service

}
