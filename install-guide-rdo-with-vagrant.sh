git clone https://github.com/marcindulak/install-guide-rdo-with-vagrant.git && \
cd install-guide-rdo-with-vagrant && \
for net in `virsh -q net-list --all | grep install-guide-rdo-with-vagrant | awk '{print $1}'`; do virsh net-destroy $net; virsh net-undefine $net; done && \
vagrant plugin install vagrant-libvirt && \
vagrant up --no-parallel controller compute1 block1 && \
virsh net-list && \
virsh net-dumpxml install-guide-rdo-with-vagrant-management && \
virsh net-dumpxml install-guide-rdo-with-vagrant-provider && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack flavor list" && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack image list" && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack network list" && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack security group list" && \
vagrant ssh controller -c "source /root/admin-openrc&& sudo su -s /bin/sh -c 'nova-manage cell_v2 discover_hosts --verbose' nova" && \
vagrant ssh controller -c 'source /root/demo-openrc&& openstack server create --flavor m1.nano --image cirros --nic net-id=`openstack network show selfservice -f json | jq ".id" | tr -d \"` --security-group default --key-name mykey selfservice-instance' && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack server list" && \
sleep 30 && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack server list" && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack server show selfservice-instance" && \
vagrant ssh controller -c "source /root/demo-openrc&& source /root/demo-openrc&& openstack floating ip create provider" && \
IP=$(vagrant ssh controller -c "source /root/demo-openrc&& openstack floating ip list -f value | cut -d' ' -f2 | tr -d '\r\n'") && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack server add floating ip selfservice-instance $IP" && \
vagrant ssh controller -c 'source /root/demo-openrc&& ping -W 1 -c 4 `openstack server show selfservice-instance -f json -c addresses |  jq ".addresses" | tr -d \" | tr -d " " | cut -d, -f2`' && \
vagrant ssh controller -c 'source /root/demo-openrc&& ssh -i ~vagrant/.ssh/id_rsa -o StrictHostKeyChecking=no cirros@`openstack server show selfservice-instance -f json -c addresses |  jq ".addresses" | tr -d \" | tr -d " " | cut -d, -f2` ip addr show' && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack volume create --size 1 volume1" && \
sleep 30 && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack volume list" && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack server add volume selfservice-instance volume1" && \
sleep 30 && \
vagrant ssh controller -c "source /root/demo-openrc&& openstack volume list" && \
vagrant ssh controller -c 'source /root/demo-openrc&& ssh -i ~vagrant/.ssh/id_rsa -o StrictHostKeyChecking=no cirros@`openstack server show selfservice-instance -f json -c addresses |  jq ".addresses" | tr -d \" | tr -d " " | cut -d, -f2` sudo fdisk -l /dev/vdb' && \
vagrant ssh controller -c 'sudo su - vagrant -c "pageres http://controller/dashboard/admin/networks/ --cookie=\"$(sh /vagrant/get_horizon_session_cookie.sh)\""' && \
vagrant destroy -f
