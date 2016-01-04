git clone https://github.com/marcindulak/vagrant-hadoop-hortonworks-tutorial-centos7.git && \
cd vagrant-hadoop-hortonworks-tutorial-centos7 && \
vagrant up && \
vagrant ssh slave0 -c "sudo su - -c 'mkfs.ext4 -F /dev/sdb'" && \
vagrant ssh slave0 -c "sudo su - -c 'echo /dev/sdb /hdfs-vagrant/data ext4 defaults,noatime >> /etc/fstab'" && \
vagrant ssh slave0 -c "sudo su - -c 'mkdir -p /hdfs-vagrant/data'" && \
vagrant ssh slave0 -c "sudo su - -c 'mount /hdfs-vagrant/data'" && \
vagrant ssh slave1 -c "sudo su - -c 'mkfs.ext4 -F /dev/sdb'" && \
vagrant ssh slave1 -c "sudo su - -c 'echo /dev/sdb /hdfs-vagrant/data ext4 defaults,noatime >> /etc/fstab'" && \
vagrant ssh slave1 -c "sudo su - -c 'mkdir -p /hdfs-vagrant/data'" && \
vagrant ssh slave1 -c "sudo su - -c 'mount /hdfs-vagrant/data'" && \
vagrant ssh master0 -c "sudo su - -c 'groupadd hadoop&& useradd -g hadoop hdfs'" && \
vagrant ssh slave0 -c "sudo su - -c 'groupadd hadoop&& useradd -g hadoop hdfs'" && \
vagrant ssh slave1 -c "sudo su - -c 'groupadd hadoop&& useradd -g hadoop hdfs'" && \
vagrant ssh gateway0 -c "sudo su - -c 'groupadd hadoop&& useradd -g hadoop hdfs'" && \
vagrant ssh slave0 -c "sudo su - -c 'chown -R hdfs:hadoop /hdfs-vagrant/data'" && \
vagrant ssh slave1 -c "sudo su - -c 'chown -R hdfs:hadoop /hdfs-vagrant/data'" && \
vagrant ssh gateway0 -c "sudo su - -c 'yum -y install ambari-server'" && \
vagrant ssh gateway0 -c "sudo su - -c \"sed -i 's|-Xms[0-9]*m |-Xms128m |' /var/lib/ambari-server/ambari-env.sh\"" && \
vagrant ssh gateway0 -c "sudo su - -c \"sed -i 's|-Xmx[0-9]*m |-Xmx128m |' /var/lib/ambari-server/ambari-env.sh\"" && \
vagrant ssh gateway0 -c "sudo su - -c 'ambari-server setup -sv -j \$(dirname \$(dirname \$(readlink -f /usr/bin/java)))'" && \
vagrant ssh gateway0 -c "sudo su - -c 'systemctl enable ambari-server.service'" && \
vagrant ssh gateway0 -c "sudo su - -c 'systemctl start ambari-server.service'" && \
sleep 120 && \
curl -H "X-Requested-By: ambari" -X GET -u admin:admin http://localhost:8080/api/v1/hosts && \
curl -H "X-Requested-By: ambari" -X POST -u admin:admin http://localhost:8080/api/v1/blueprints/vagrant -d @vagrant-blueprint.json && \
curl -H "X-Requested-By: ambari" -X GET -u admin:admin http://localhost:8080/api/v1/blueprints && \
curl -H "X-Requested-By: ambari" -X POST -u admin:admin http://localhost:8080/api/v1/clusters/vagrant -d @vagrant-cluster.json && \
sleep 3000 && \
curl -H "X-Requested-By: ambari" -X GET -u admin:admin http://localhost:8080/api/v1/clusters/vagrant/alerts?Alert/state!=OK && \
vagrant ssh gateway0 -c "sudo su - hdfs -c 'hdfs dfsadmin -report'" && \
vagrant ssh gateway0 -c "sudo su - hdfs -c 'hadoop fs -mkdir -p /user/vagrant'" && \
vagrant ssh gateway0 -c "sudo su - hdfs -c 'hadoop fs -chown vagrant:vagrant /user/vagrant'" && \
vagrant ssh gateway0 -c "sudo su - -c 'yum -y install java-1.8.0-openjdk-devel'" && \
vagrant ssh gateway0 -c "sudo su - vagrant -c 'wget https://raw.githubusercontent.com/marcindulak/vagrant-hadoop-hortonworks-tutorial-centos7/master/LICENSE'" && \
vagrant ssh gateway0 -c "sudo su - vagrant -c 'hadoop fs -mkdir -p /user/vagrant/WordCount/input'" && \
vagrant ssh gateway0 -c "sudo su - vagrant -c 'hadoop fs -put LICENSE /user/vagrant/WordCount/input'" && \
vagrant ssh gateway0 -c "sudo su - vagrant -c 'hadoop fs -cat /user/vagrant/WordCount/input/*'" && \
vagrant ssh gateway0 -c "sudo su - vagrant -c 'wget https://raw.githubusercontent.com/marcindulak/vagrant-hadoop-hortonworks-tutorial-centos7/master/WordCount.sh'" && \
vagrant ssh gateway0 -c "sudo su - vagrant -c 'sh WordCount.sh'" && \
vagrant ssh gateway0 -c "sudo su - vagrant -c 'hadoop fs -cat /user/vagrant/WordCount/mapreduce-output/*'" && \
vagrant ssh gateway0 -c "sudo su - vagrant -c 'wget https://raw.githubusercontent.com/marcindulak/vagrant-hadoop-hortonworks-tutorial-centos7/master/wc.pig'" && \
vagrant ssh gateway0 -c "sudo su - vagrant -c 'pig wc.pig'" && \
vagrant ssh gateway0 -c "sudo su - vagrant -c 'hadoop fs -cat /user/vagrant/WordCount/pig-mapreduce-output/*'" && \
vagrant destroy -f

