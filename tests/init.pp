## Simple Server/Client test of NFS

## Setup the Server
file{['/mnt/nfs','/mnt/nfs_client']:
  ensure => directory,
}

class{'nfs::server':
  require => File['/mnt/nfs','/mnt/nfs_client'],
}

nfs::server::export { '/mnt/nfs':
  ensure  => mounted,
  clients => ['localhost(rw,async)'],
  require => Class['nfs::server'],
}


## Setup the client
class{'nfs::client':
  require => Nfs::Server::Export['/mnt/nfs'],
}

mount{'/mnt/nfs_client':
  ensure  => mounted,
  fstype  => 'nfs4',
  device  => 'localhost:/mnt/nfs',
  options => 'defaults',
  atboot  => true,
  require => Class['nfs::client']
}
