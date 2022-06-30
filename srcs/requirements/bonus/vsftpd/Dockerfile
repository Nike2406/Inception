FROM debian:buster

RUN apt-get update && apt-get install vsftpd -y

COPY conf/vsftpd.conf /var/www/vsftpd.conf
COPY tools/set_ftp.sh /var/www/set_ftp.sh

CMD bash /var/www/set_ftp.sh