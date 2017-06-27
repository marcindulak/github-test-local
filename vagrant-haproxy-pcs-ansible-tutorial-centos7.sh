git clone https://github.com/marcindulak/vagrant-haproxy-pcs-ansible-tutorial-centos7.git && \
cd vagrant-haproxy-pcs-ansible-tutorial-centos7 && \
cd ansible/roles/external && \
git clone https://github.com/marcindulak/ansible-pacemaker styopa.pacemaker && \
cd - && \
vagrant plugin install landrush && \
vagrant up || : && \
sleep 30 && \
vagrant ssh mgt1.mydomain -c "curl -sgG --data-urlencode query='up{instance=~\"app.*\", job=\"node_exporter\"}' localhost:9090/api/v1/query | python -m json.tool" && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook.yml" && \
vagrant provision mgt1.mydomain && \
vagrant ssh mgt1.mydomain -c "curl loadbalancer:80" && \
curl localhost:40080 && \
vagrant ssh mgt1.mydomain -c "curl app1:8080" && \
vagrant ssh mgt1.mydomain -c "curl lb1:80" && \
cp -pf ansible/playbook.yml ansible/playbook.yml.rollback && \
sed -i 's/gs-spring-boot/gs-testing-web/' ansible/playbook.yml && \
vagrant ssh mgt1.mydomain -c "ansible app1.mydomain -i /vagrant/ansible/hosts.yml -a 'systemctl stop gs-spring-boot' --become" && \
vagrant ssh mgt1.mydomain -c "ansible app1.mydomain -i /vagrant/ansible/hosts.yml -a 'systemctl disable gs-spring-boot' --become" && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook.yml -l app1.mydomain" && \
sleep 30 && \
vagrant ssh mgt1.mydomain -c "curl app1:8080" | grep "Hello World" && \
vagrant destroy -f app1.mydomain && \
vagrant up app1.mydomain && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook.yml.rollback" && \
sleep 30 && \
vagrant ssh mgt1.mydomain -c "curl app1:8080" | grep "Greetings from Spring Boot!" && \
ACTIVE_LB=`vagrant ssh lb1.mydomain -c "sudo su - -c \"pcs status | grep virtual-ip | cut -d: -f5 | cut -d' ' -f2 | tr -d '\n'\""` && \
if `echo $ACTIVE_LB | grep -q lb1`; then PASSIVE_LB=lb2.mydomain; else PASSIVE_LB=lb1.mydomain; fi && \
vagrant destroy -f $ACTIVE_LB && \
vagrant ssh $PASSIVE_LB -c "sudo su - -c 'pcs status'" && \
vagrant ssh mgt1.mydomain -c "curl loadbalancer:80" && \
vagrant up $ACTIVE_LB && \
vagrant ssh $PASSIVE_LB -c "scp -o StrictHostKeyChecking=no -p /etc/corosync/corosync.conf $ACTIVE_LB:/tmp" && \
vagrant ssh $ACTIVE_LB -c "sudo su - -c 'mkdir /etc/corosync&& mv /tmp/corosync.conf /etc/corosync&& chown root.root /etc/corosync/corosync.conf'" && \
vagrant ssh $ACTIVE_LB -c "sudo su - -c 'semanage fcontext -a -s system_u -t etc_t /etc/corosync/corosync.conf'" && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook.yml.rollback" && \
vagrant ssh $ACTIVE_LB -c "sudo su - -c 'pcs status'" && \
vagrant destroy -f
