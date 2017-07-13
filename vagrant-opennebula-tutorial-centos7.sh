git clone https://github.com/marcindulak/vagrant-opennebula-tutorial-centos7.git && \
cd vagrant-opennebula-tutorial-centos7 && \
vagrant plugin install vagrant-libvirt && \
vagrant up --no-parallel && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onehost create node1 -i kvm -v kvm'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onehost list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'echo NAME = private > mynetwork.one; echo VN_MAD = dummy >> mynetwork.one; echo BRIDGE = br1 >> mynetwork.one; echo AR = [TYPE = IP4, IP = 192.168.10.100, SIZE = 3] >> mynetwork.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onevnet list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onevnet create mynetwork.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onevnet list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'oneimage create --name ttylinux --path http://marketplace.c12g.com/appliance/4fc76a938fb81d3517000003/download --datastore default --prefix hd'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'oneimage list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onetemplate create --name ttylinux --cpu 1 --vcpu 1 --memory 127 --arch x86_64 --disk ttylinux --nic private --vnc --ssh --net_context'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onetemplate list'" && \
sleep 30 && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onetemplate instantiate ttylinux'" && \
sleep 300 && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onevm list'" && \
vagrant ssh frontend -c "sudo su - -c 'yum -y install sshpass'" && \
vagrant ssh frontend -c "sshpass -p password ssh -o StrictHostKeyChecking=no root@192.168.10.100 '/sbin/ifconfig eth0'" && \
vagrant destroy -f
