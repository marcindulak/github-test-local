git clone https://github.com/marcindulak/vagrant-mariadb-galera-tutorial-centos7.git && \
cd vagrant-mariadb-galera-tutorial-centos7 && \
CONTROLLER=IDE vagrant up && \
vagrant ssh node0 -c "sudo su - -c 'cat /etc/my.cnf.d/server.cnf'" && \
vagrant ssh node0 -c "sudo su - -c 'galera_new_cluster'" && \
vagrant ssh node0 -c "echo \"SHOW STATUS LIKE 'wsrep_cluster_size'\" | mysql --user=root --password=ROOT_PASSWORD" | grep wsrep_cluster_size | grep -q 1 && \
vagrant ssh node1 -c "sudo su - -c 'systemctl start mariadb'" && \
vagrant ssh node2 -c "sudo su - -c 'systemctl start mariadb'" && \
vagrant ssh node2 -c "echo \"SELECT VARIABLE_VALUE FROM INFORMATION_SCHEMA.GLOBAL_STATUS WHERE VARIABLE_NAME='wsrep_cluster_size'\" | mysql --user=root --password=ROOT_PASSWORD" | tail -n -1 | grep -q 3 && \
vagrant ssh node2 -c "echo \"SHOW STATUS LIKE 'wsrep_cluster_status'\" | mysql --user=root --password=ROOT_PASSWORD" | grep wsrep_cluster_status | grep -q Primary && \
vagrant ssh node2 -c "echo \"SHOW STATUS LIKE 'wsrep_connected'\" | mysql --user=root --password=ROOT_PASSWORD" | grep wsrep_connected | grep -q ON && \
vagrant ssh node2 -c "echo \"SHOW STATUS LIKE 'wsrep_local_state'\" | mysql --user=root --password=ROOT_PASSWORD" | grep wsrep_local_state | grep -q 4 && \
vagrant ssh client0 -c "sudo su - -c 'yum -y install mariadb'" && \
vagrant ssh node0 -c "echo \"GRANT ALL PRIVILEGES ON *.* to vagrant@'client0' IDENTIFIED BY 'vagrant';\" | mysql --user=root --password=ROOT_PASSWORD" && \
vagrant ssh node1 -c "echo \"GRANT ALL PRIVILEGES ON *.* to vagrant@'client0' IDENTIFIED BY 'vagrant';\" | mysql --user=root --password=ROOT_PASSWORD" && \
vagrant ssh node2 -c "echo \"GRANT ALL PRIVILEGES ON *.* to vagrant@'client0' IDENTIFIED BY 'vagrant';\" | mysql --user=root --password=ROOT_PASSWORD" && \
vagrant ssh client0 -c "echo \"SELECT VARIABLE_VALUE FROM INFORMATION_SCHEMA.GLOBAL_STATUS WHERE VARIABLE_NAME='wsrep_cluster_size'\" | mysql --host=node2 --user=vagrant --password=vagrant" && \
vagrant ssh client0 -c "echo \"CREATE DATABASE vagrant;\" | mysql --host=node1 --user=vagrant --password=vagrant" && \
vagrant ssh client0 -c "echo \"CREATE TABLE vagrant.cluster (id INT NOT NULL AUTO_INCREMENT, node VARCHAR(5), PRIMARY KEY(id));\" | mysql --host=node0 --user=vagrant --password=vagrant" && \
vagrant ssh client0 -c "echo \"INSERT INTO vagrant.cluster (node) VALUES ('node2');\" | mysql --host=node2 --user=vagrant --password=vagrant" && \
vagrant ssh node0 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q node2 && \
vagrant ssh node1 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q node2 && \
vagrant ssh node2 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q node2 && \
! vagrant ssh node2 -c "sudo su - -c 'shutdown -h now'" && \
sleep 30 && \
vagrant ssh node0 -c "echo \"SHOW STATUS LIKE 'wsrep_cluster_size'\" | mysql --user=root --password=ROOT_PASSWORD" | grep wsrep_cluster_size | grep -q 2 && \
vagrant ssh client0 -c "echo \"INSERT INTO vagrant.cluster (node) VALUES ('fail1');\" | mysql --host=node0 --user=vagrant --password=vagrant" && \
vagrant ssh node0 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q fail1 && \
vagrant ssh node1 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q fail1 && \
CONTROLLER=IDE vagrant up && \
vagrant ssh node0 -c "sudo su - -c 'cat /var/lib/mysql/grastate.dat'" | grep "seqno:" | grep -q "\-1" && \
vagrant ssh node1 -c "sudo su - -c 'cat /var/lib/mysql/grastate.dat'" | grep "seqno:" | grep -q "\-1" && \
vagrant ssh node2 -c "sudo su - -c 'cat /var/lib/mysql/grastate.dat'" | grep "seqno:" | grep -q "6" && \
vagrant ssh node2 -c "sudo su - -c 'systemctl start mariadb'" && \
vagrant ssh node2 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q fail1 && \
! vagrant ssh node2 -c "sudo su - -c 'shutdown -h now'" && \
! vagrant ssh node1 -c "sudo su - -c 'shutdown -h now'" && \
sleep 30 && \
vagrant ssh node0 -c "echo \"SHOW STATUS LIKE 'wsrep_cluster_size'\" | mysql --user=root --password=ROOT_PASSWORD" | grep wsrep_cluster_size | grep -q 1 && \
vagrant ssh client0 -c "echo \"INSERT INTO vagrant.cluster (node) VALUES ('fail2');\" | mysql --host=node0 --user=vagrant --password=vagrant" && \
vagrant ssh node0 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q fail2 && \
CONTROLLER=IDE vagrant up && \
vagrant ssh node0 -c "sudo su - -c 'cat /var/lib/mysql/grastate.dat'" | grep "seqno:" | grep -q "\-1" && \
vagrant ssh node1 -c "sudo su - -c 'cat /var/lib/mysql/grastate.dat'" | grep "seqno:" | grep -q "7" && \
vagrant ssh node2 -c "sudo su - -c 'cat /var/lib/mysql/grastate.dat'" | grep "seqno:" | grep -q "7" && \
vagrant ssh node1 -c "sudo su - -c 'systemctl start mariadb'" && \
vagrant ssh node1 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q fail2 && \
vagrant ssh node2 -c "sudo su - -c 'systemctl start mariadb'" && \
vagrant ssh node2 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q fail2 && \
! vagrant ssh node2 -c "sudo su - -c 'shutdown -h now'" && \
! vagrant ssh node1 -c "sudo su - -c 'shutdown -h now'" && \
sleep 30 && \
vagrant ssh node0 -c "echo \"SHOW STATUS LIKE 'wsrep_cluster_size'\" | mysql --user=root --password=ROOT_PASSWORD" | grep wsrep_cluster_size | grep -q 1 && \
vagrant ssh client0 -c "echo \"INSERT INTO vagrant.cluster (node) VALUES ('fail3');\" | mysql --host=node0 --user=vagrant --password=vagrant" && \
vagrant ssh node0 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q fail3 && \
! vagrant ssh node0 -c "sudo su - -c 'shutdown -h now'" && \
sleep 30 && \
CONTROLLER=IDE vagrant up && \
vagrant ssh node0 -c "sudo su - -c 'cat /var/lib/mysql/grastate.dat'" | grep "seqno:" | grep -q "9" && \
vagrant ssh node1 -c "sudo su - -c 'cat /var/lib/mysql/grastate.dat'" | grep "seqno:" | grep -q "8" && \
vagrant ssh node2 -c "sudo su - -c 'cat /var/lib/mysql/grastate.dat'" | grep "seqno:" | grep -q "8" && \
vagrant ssh node0 -c "sudo su - -c 'mysqld --user=mysql --wsrep-recover'" && \
vagrant ssh node0 -c "sudo su - -c 'galera_new_cluster'" && \
vagrant ssh node1 -c "sudo su - -c 'systemctl start mariadb'" && \
vagrant ssh node2 -c "sudo su - -c 'systemctl start mariadb'" && \
vagrant ssh node0 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q fail3 && \
vagrant ssh node1 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q fail3 && \
vagrant ssh node2 -c "echo \"SELECT node FROM vagrant.cluster;\" | mysql --user=root --password=ROOT_PASSWORD" | grep -q fail3 && \
vagrant destroy -f
