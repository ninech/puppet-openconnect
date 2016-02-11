# == Class: openconnect
#
# Cisco OpenConnect VPN client.
#
# === Parameters
#
# [*url*]
#   URL for your VPN endpoint, including any profile name.
#
# [*user*]
#   Xauth username.
#
# [*pass*]
#   Xauth password.
#
# [*dnsupdate*]
#   Boolean, whether to accept nameservers from the VPN endpoint.
#   Default: true
#
# [*nocertcheck*]
#   Boolean, whether to accept server SSL cert to be valid.
#   Default: false
#
# [*nodtlsk*]
#   Boolean, whether to disable DTLS or not
#   Default: false
#
# [*cacerts*]
#   PEM string of CAs to trust.
#   Default: ''
#
# [*servercert*]
#   SHA1 fingerprint of trusted server's SSL certificate.
#   Default: ''
#
class openconnect(
  $url,
  $user,
  $pass,
  $dnsupdate = true,
  $nocertcheck = false,
  $nodtls = false,
  $cacerts = '',
  $servercert = ''
) inherits openconnect::params {

  anchor { 'openconnect::begin': } ->
  class { 'openconnect::install': } ->
  class { 'openconnect::config': }
  class { 'openconnect::service': } ->
  anchor { 'openconnect::end': }

  Anchor['openconnect::begin']  ~> Class['openconnect::service']
  Class['openconnect::install'] ~> Class['openconnect::service']
  Class['openconnect::config']  ~> Class['openconnect::service']
}
