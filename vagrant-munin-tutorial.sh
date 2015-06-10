cd ~/github/test
rm -rfv vagrant-munin-tutorial
git clone https://github.com/marcindulak/vagrant-munin-tutorial.git
cd vagrant-munin-tutorial
vagrant up
sleep 360
curl --user munin:munin http://localhost:8080/munin/
#
vagrant ssh centos6 -c "sudo su -c 'cd /etc/munin/plugins/; ln -s /usr/share/munin/plugins/apache_accesses'"
vagrant ssh centos6 -c "sudo su -c 'cd /etc/munin/plugins/; ln -s /usr/share/munin/plugins/apache_processes'"
vagrant ssh centos6 -c "sudo su -c 'cd /etc/munin/plugins/; ln -s /usr/share/munin/plugins/apache_volume'"
vagrant ssh centos6 -c "sudo su -c 'echo \"[apache_*]\" > /etc/munin/plugin-conf.d/apache'"
vagrant ssh centos6 -c "sudo su -c 'service munin-node reload'"
vagrant ssh centos6 -c "sudo su -c 'service httpd start'"
sleep 360
vagrant ssh centos6 -c "sudo su -c 'curl http://localhost/'"
vagrant destroy -f
