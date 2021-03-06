#!/bin/bash

#Install LetsEncrypt
wget http://dl.mycity.tech/vesta/generate_ssl -O /usr/local/bin/generate_ssl
chmod u+x /usr/local/bin/generate_ssl

cert_src="/home/admin/conf/web/ssl.yourdomain.com.pem"
key_src="/home/admin/conf/web/ssl.yourdomain.com.key"
cert_dst="/usr/local/vesta/ssl/certificate.crt"
key_dst="/usr/local/vesta/ssl/certificate.key"


if ! cmp -s $cert_dst $cert_src
then
        # Copy Certificate
        cp $cert_src $cert_dst

        # Copy Keyfile
        cp $key_src $key_dst

        # Change Permission
        chown root:mail $cert_dst
        chown root:mail $key_dst

        # Restart Services
        service vesta restart &> /dev/null
        service exim4 restart &> /dev/null
fi
