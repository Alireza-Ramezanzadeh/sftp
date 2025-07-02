#!/bin/sh

if [ -n "$ROOT_PASSWORD" ]; then
  echo "root:${ROOT_PASSWORD}" | chpasswd
fi

if [ -n "$WWW_DATA_PASSWORD" ]; then
  echo "www-data:${WWW_DATA_PASSWORD}" | chpasswd
fi

mkdir -p /sftp/www-data
chown root:root /sftp
chmod 755 /sftp
chown www-data:www-data /sftp/www-data
chmod 755 /sftp/www-data

rm -rf /var/www
ln -s /sftp/www-data /var/www

{

  echo 'PasswordAuthentication yes'
  echo 'AllowTcpForwarding no'
  echo 'PermitTunnel no'
  echo 'X11Forwarding no'
  echo ''
  echo 'Match User www-data'
  echo '  ChrootDirectory /var/www'
  echo '  ForceCommand internal-sftp'
  echo '  AllowAgentForwarding no'

} >> /etc/ssh/sshd_config

exec /usr/sbin/sshd -D -e
