git clone https://github.com/marcindulak/puppet-nagios.git && \
cd puppet-nagios && \
vagrant up && \
vagrant ssh nagiosserver -c "sudo su -c 'service httpd start'" && \
! vagrant ssh nagiosserver -c "sudo su -c '/usr/lib64/nagios/plugins/check_http -H centos7'" && \
vagrant ssh centos7 -c "sudo su -c 'yum install -y httpd'" && \
vagrant ssh centos7 -c "sudo su -c 'touch /var/www/html/index.html'" && \
vagrant ssh centos7 -c "sudo su -c 'chown apache.apache /var/www/html/index.html'" && \
vagrant ssh centos7 -c "sudo su -c 'service httpd restart'" && \
vagrant ssh nagiosserver -c "sudo su -c '/usr/lib64/nagios/plugins/check_http -H centos7'" && \
vagrant ssh nagiosserver -c "sudo su -c '/usr/lib64/nagios/plugins/check_nrpe -H centos7 -c check_total_procs -a 150 200'" && \
vagrant destroy -f
