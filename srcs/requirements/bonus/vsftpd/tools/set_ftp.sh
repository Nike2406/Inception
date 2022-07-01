#!/bin/bash

echo "VSFTPD: Trying to set up VSFTPD"
if [ ! -f "/etc/vsftpd.conf.bak" ]; then
    
    echo "VSFTPD: Start to set"
    mkdir -p /var/run/vsftpd/empty

    cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
	mv /var/www/vsftpd.conf /etc/vsftpd.conf

    # Add the FTP_USER, change his password and declare him as the owner of wordpress folder and all subfolders
    adduser $FTP_USR --disabled-password
    echo "$FTP_USR:$FTP_PWD" | /usr/sbin/chpasswd &> /dev/null
    chown -R $FTP_USR:$FTP_USR /var/www/html/wordpress

    echo $FTP_USR | tee -a /etc/vsftpd.userlist &> /dev/null

    echo "VSFTPD: Started on :21"
else
    echo "VSFTPD: setup already exists!"
fi
/usr/sbin/vsftpd /etc/vsftpd.conf