git clone https://github.com/marcindulak/vagrant-opennebula-tutorial-centos7.git && \
cd vagrant-opennebula-tutorial-centos7 && \
vagrant plugin install vagrant-libvirt && \
vagrant up --no-parallel && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onehost create node1 -i kvm -v kvm'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onehost list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onedatastore list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'echo NAME = system > system.one&& echo TM_MAD = shared >> system.one&& echo TYPE = SYSTEM_DS >> system.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onedatastore update system system.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onedatastore list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'echo NAME = default > default.one&& echo DS_MAD = fs >> default.one&& echo TM_MAD = shared >> default.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onedatastore update default default.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'echo NAME = files > files.one&& echo DS_MAD = fs >> files.one&& echo TM_MAD = shared >> files.one && echo TYPE = FILE_DS >> files.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onedatastore update files files.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onedatastore list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'echo NAME = private > private.one; echo VN_MAD = dummy >> private.one; echo BRIDGE = br1 >> private.one; echo AR = [TYPE = IP4, IP = 192.168.10.100, SIZE = 3] >> private.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onevnet list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onevnet create private.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onevnet list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'oneimage create --name testvm --path http://marketplace.opennebula.systems/appliance/4e3b2788-d174-4151-b026-94bb0b987cbb/download --datastore default --prefix vd --driver qcow2'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'oneimage list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onetemplate create --name testvm --cpu 1 --vcpu 1 --memory 256 --arch x86_64 --disk testvm --nic private --vnc --ssh --net_context'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onetemplate list'" && \
sleep 30 && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'echo CONTEXT = [ USERNAME = root, PASSWORD = password, NETWORK = YES ] > context.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onetemplate update testvm -a context.one'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onetemplate instantiate testvm'" && \
sleep 300 && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onevm list'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onehost show 0'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onevnet show 0'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'oneimage show 0'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onetemplate show 0'" && \
vagrant ssh frontend -c "sudo su - oneadmin -c 'onevm show 0'" && \
vagrant ssh node1 -c "sudo su - -c 'virsh dumpxml one-0'" && \
vagrant ssh frontend -c "sudo su - -c 'yum -y install sshpass'" && \
vagrant ssh frontend -c "sshpass -p password ssh -o StrictHostKeyChecking=no root@192.168.10.100 '/sbin/ifconfig'" && \
vagrant destroy -f
