# == Class: docker::config
#
class docker::config {
  docker::system_user { $docker::docker_users: }

  if $docker::registry_cert {
    $cert_dir = '/etc/docker/certs.d'
    $registry_dir = "${cert_dir}/${docker::registry_cert['registry_name']}"

    file { $cert_dir:
      ensure => 'directory',
    } ->

    file { $registry_dir:
      ensure => 'directory',
    } ->

    file { "${registry_dir}/ca.crt":
      mode   => '0644',
      owner  => root,
      group  => root,
      source => $docker::registry_cert['source'],
    }
  }
}