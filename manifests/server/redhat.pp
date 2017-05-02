class nfs::server::redhat(
  $nfs_v4              = false,
  $nfs_v4_idmap_domain = undef,
  $mountd_port         = undef,
  $mountd_threads      = 1,
  $statd_port          = undef,
  $statd_outgoingport  = undef,
  $lockd_tcpport       = undef,
  $lockd_udpport       = undef,
  $rquotad_port        = undef,
  $service_manage      = true,
) {
  if $::operatingsystemmajrelease and $::operatingsystemmajrelease =~ /^7/ {
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
    file_line { 'mountd-port':
      ensure => present,
      path   => '/etc/sysconfig/nfs',
      line   => "MOUNTD_PORT=${mountd_port}",
      match  => '^#?MOUNTD_PORT';
    }

    if $service_manage {
      File_line['mountd-port'] ~> Service[$service_name]
    }
  }

  if ($statd_port != undef){
    file_line { 'statd-port':
      ensure => present,
      path   => '/etc/sysconfig/nfs',
      line   => "STATD_PORT=${statd_port}",
      match  => '^#?STATD_PORT';
    }

    if $service_manage {
      File_line['statd-port'] ~> Service[$service_name]
    }
  }

  if ($statd_outgoingport != undef){
    file_line { 'statd-outgoingport':
      ensure => present,
      path   => '/etc/sysconfig/nfs',
      line   => "STATD_OUTGOING_PORT=${statd_outgoingport}",
      match  => '^#?STATD_OUTGOING_PORT';
    }

    if $service_manage {
      File_line['statd-outgoingport'] ~> Service[$service_name]
    }
  }

  if ($lockd_tcpport != undef){
    file_line { 'lockd-tcpport':
      ensure => present,
      path   => '/etc/sysconfig/nfs',
      line   => "LOCKD_TCPPORT=${lockd_tcpport}",
      match  => '^#?LOCKD_TCPPORT';
    }

    if $service_manage {
      File_line['lockd-tcpport'] ~> Service[$service_name]
    }
  }

  if ($lockd_udpport != undef){
    file_line { 'lockd-udpport':
      ensure => present,
      path   => '/etc/sysconfig/nfs',
      line   => "LOCKD_UDPPORT=${lockd_udpport}",
      match  => '^#?LOCKD_UDPPORT';
    }

    if $service_manage {
      File_line['lockd-udpport'] ~> Service[$service_name]
    }
  }

  if ($rquotad_port != undef){
    file_line { 'rquotad-port':
      ensure => present,
      path   => '/etc/sysconfig/nfs',
      line   => "RQUOTAD_PORT=${rquotad_port}",
      match  => '^#?RQUOTAD_PORT';
    }

    if $service_manage {
      File_line['rquotad-port'] ~> Service[$service_name]
    }
  }

  include nfs::server::redhat::install, nfs::server::redhat::service

}
