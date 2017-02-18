git clone https://github.com/marcindulak/vagrant-munin-tutorial.git && \
cd vagrant-munin-tutorial && \
vagrant up && \
sleep 360 && \
curl --user munin:munin http://localhost:8080/munin/ && \
vagrant ssh centos7 -c "sudo su -c 'cd /etc/munin/plugins/; ln -s /usr/share/munin/plugins/apache_accesses'" && \
vagrant ssh centos7 -c "sudo su -c 'cd /etc/munin/plugins/; ln -s /usr/share/munin/plugins/apache_processes'" && \
vagrant ssh centos7 -c "sudo su -c 'cd /etc/munin/plugins/; ln -s /usr/share/munin/plugins/apache_volume'" && \
vagrant ssh centos7 -c "sudo su -c 'echo \"[apache_*]\" > /etc/munin/plugin-conf.d/apache'" && \
vagrant ssh centos7 -c "sudo su -c 'service munin-node restart'" && \
! vagrant ssh centos7 -c "sudo su -c 'curl http://localhost/'" && \
vagrant ssh centos7 -c "sudo su -c 'service httpd restart'" && \
sleep 360 && \
vagrant ssh centos7 -c "sudo su -c 'curl http://localhost/'" && \
vagrant destroy -f
