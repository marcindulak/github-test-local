git clone https://github.com/marcindulak/vagrant-opennebula-ha-tutorial-centos7.git && \
cd vagrant-opennebula-ha-tutorial-centos7 && \
for net in `virsh -q net-list --all | grep vagrant-opennebula-ha | awk '{print $1}'`; do virsh net-destroy $net; virsh net-undefine $net; done && \
vagrant plugin install landrush && \
vagrant plugin install vagrant-libvirt && \
vagrant up --no-parallel one1.mydomain one2.mydomain one3.mydomain mgt1.mydomain || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-mgt-setup.yml" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-glusterfs-setup.yml" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-glusterfs-setup.yml" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-glusterfs-setup.yml" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-frontend-setup.yml" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-frontend-setup.yml" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-frontend-setup.yml" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-node-setup.yml" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-node-setup.yml" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-node-setup.yml" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-frontend-ha-leader-setup.yml --extra-vars 'opennebula_ha_leader=one1.mydomain'" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-frontend-ha-leader-setup.yml --extra-vars 'opennebula_ha_leader=one1.mydomain'" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-frontend-ha-follower-setup.yml --extra-vars 'opennebula_ha_follower=one2.mydomain'" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-frontend-ha-follower-setup.yml --extra-vars 'opennebula_ha_follower=one2.mydomain'" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-frontend-ha-follower-setup.yml --extra-vars 'opennebula_ha_follower=one3.mydomain'" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-frontend-ha-follower-setup.yml --extra-vars 'opennebula_ha_follower=one3.mydomain'" || : && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onehost create one1.mydomain -i kvm -v kvm && onehost create one2.mydomain -i kvm -v kvm && onehost create one3.mydomain -i kvm -v kvm'" && \
sleep 10 && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onehost list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onedatastore list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'echo NAME = system > system.one&& echo TM_MAD = shared >> system.one&& echo TYPE = SYSTEM_DS >> system.one'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onedatastore update system system.one'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onedatastore list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'echo NAME = default > default.one&& echo DS_MAD = fs >> default.one&& echo TM_MAD = shared >> default.one'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onedatastore update default default.one'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'echo NAME = files > files.one&& echo DS_MAD = fs >> files.one&& echo TM_MAD = shared >> files.one && echo TYPE = FILE_DS >> files.one'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onedatastore update files files.one'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onedatastore list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevnet list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'echo NAME = private > private.one&& echo VN_MAD = dummy >> private.one&& echo BRIDGE = br1 >> private.one&& echo AR = [TYPE = IP4, IP = 192.168.123.100, SIZE = 3] >> private.one&& echo DNS = 192.168.123.1 >> private.one'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevnet create private.one'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevnet list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'oneimage list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'oneimage create --name centos7 --path http://marketplace.opennebula.systems/appliance/4e3b2788-d174-4151-b026-94bb0b987cbb/download --datastore default --prefix vd --driver qcow2'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'oneimage list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onetemplate list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onetemplate create --name centos7 --cpu 1 --vcpu 1 --memory 256 --arch x86_64 --disk centos7 --nic private --vnc --ssh --net_context'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onetemplate list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'echo CONTEXT = [ USERNAME = root, PASSWORD = password, NETWORK = YES  ] > context.one'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onetemplate update centos7 -a context.one'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevm list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onetemplate instantiate centos7'" && \
sleep 60 && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevm list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onezone show 0'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onehost show 0'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevnet show 0'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'oneimage show 0'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onetemplate show 0'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevm show 0'" && \
vagrant ssh one3.mydomain -c "sudo su - -c 'virsh dumpxml one-0'" && \
vagrant ssh one1.mydomain -c "sudo su - -c 'yum -y install sshpass'" && \
vagrant ssh one1.mydomain -c "sshpass -p password ssh -o StrictHostKeyChecking=no root@192.168.123.100 '/sbin/ifconfig'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevm list | grep one3'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevm migrate 0 one2.mydomain --live'" && \
sleep 10 && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevm list | grep one2'" && \
vagrant suspend one1.mydomain && \
vagrant ssh one2.mydomain -c "sudo su - oneadmin -c 'onezone show 0'" && \
CURRENT_LEADER=`vagrant ssh one2.mydomain -c "sudo su - oneadmin -c 'onezone show 0'" | grep leader | awk '{print $2}'` && \
vagrant ssh $CURRENT_LEADER -c "sudo su - oneadmin -c 'onevm migrate 0 one3.mydomain --live'" && \
sleep 10 && \
vagrant ssh $CURRENT_LEADER -c "sudo su - oneadmin -c 'onevm list | grep one3'" && \
vagrant reload one1.mydomain && \
vagrant ssh $CURRENT_LEADER -c "sudo su - oneadmin -c 'onezone show 0'" && \
vagrant ssh $CURRENT_LEADER -c "sudo su - oneadmin -c 'onehost list'" && \
vagrant destroy -f one3.mydomain && \
sleep 180 && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onezone show 0'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevm list | grep one3 | grep unkn'" && \
vagrant up one3.mydomain && \
vagrant ssh mgt1.mydomain -c "ssh-keygen -R one3.mydomain" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'ssh-keygen -R one3.mydomain'" && \
vagrant ssh one2.mydomain -c "sudo su - oneadmin -c 'ssh-keygen -R one3.mydomain'" && \
vagrant ssh mgt1.mydomain -c "ssh -o StrictHostKeyChecking=no one3.mydomain hostname" && \
UUID=`vagrant ssh one1.mydomain -c "sudo su - -c 'grep glusterfs-one3.mydomain -r /var/lib/glusterd/peers | cut -d: -f1 | cut -d/ -f6'" | tr -d ' '` && \
VOLUME_ID=`vagrant ssh one1.mydomain -c "sudo su - -c 'getfattr -n trusted.glusterfs.volume-id /data/glusterfs/datastore1/brick1/brick 2>/dev/null | grep volume-id | cut -d= -f2-'" | tr -d ' '` && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-glusterfs-replace.yml --extra-vars 'gluster_server_node=one1.mydomain gluster_replace_node=one3.mydomain gluster_replace_uuid=$UUID gluster_volume_id=$VOLUME_ID'" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-frontend-setup.yml" || : && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-node-setup.yml" || : && \
CURRENT_LEADER=`vagrant ssh one2.mydomain -c "sudo su - oneadmin -c 'onezone show 0'" | grep leader | awk '{print $2}'` && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onezone server-del 0 2'" && \
vagrant ssh mgt1.mydomain -c "ansible-playbook -i /vagrant/ansible/hosts.yml /vagrant/ansible/playbook-one-frontend-ha-follower-setup.yml --extra-vars 'opennebula_ha_leader=$CURRENT_LEADER opennebula_ha_follower=one3.mydomain'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onezone show 0'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onehost list'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevm list | grep one3 | grep poff'" && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevm resume 0'" && \
sleep 30 && \
vagrant ssh one1.mydomain -c "sudo su - oneadmin -c 'onevm list | grep one3'" && \
vagrant ssh one1.mydomain -c "sshpass -p password ssh -o StrictHostKeyChecking=no root@192.168.123.100 '/sbin/ifconfig'" && \
vagrant destroy -f

