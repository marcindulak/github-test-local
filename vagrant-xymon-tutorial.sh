cd /scratch/ubuntu/github/test && \
rm -rfv vagrant-xymon-tutorial && \
git clone https://github.com/marcindulak/vagrant-xymon-tutorial.git && \
cd vagrant-xymon-tutorial && \
vagrant up && \
curl --insecure --user Xymon:Xymon https://localhost:8443/xymon/ && \
vagrant ssh centos6 -c "sudo su -c 'yum install -y httpd'" && \
vagrant ssh centos6 -c "sudo su -c 'service httpd start'" && \
vagrant ssh centos6 -c "sudo su -c 'touch /var/www/html/index.html'" && \
vagrant ssh centos6 -c "sudo su -c 'chown apache.apache /var/www/html/index.html'" && \
vagrant ssh centos6 -c "sudo su -c 'service httpd reload'" && \
vagrant destroy -f
