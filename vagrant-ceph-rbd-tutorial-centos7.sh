git clone https://github.com/marcindulak/vagrant-ceph-rbd-tutorial-centos7.git && \
cd vagrant-ceph-rbd-tutorial-centos7 && \
CONTROLLER=IDE vagrant up && \
vagrant ssh server0 -c "sudo su - ceph -c 'ceph-deploy new server{0,1,2}'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'echo public_network = 192.168.10.0/24 >> ceph.conf'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'echo cluster_network = 192.168.10.0/24 >> ceph.conf'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'echo [osd] >> ceph.conf'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'echo osd_journal_size = 0 >> ceph.conf'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'ceph-deploy mon create server{0,1,2}'" && \
sleep 30 && \
vagrant ssh server0 -c "sudo su - ceph -c 'ceph-deploy gatherkeys server0'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'ceph-deploy admin server{0,1,2}'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'ceph-deploy disk list server{0,1,2}'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'ceph-deploy disk zap server0:sdb server1:sdb server2:sdb'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'ceph-deploy osd prepare server0:sdb:/dev/sdc server1:sdb:/dev/sdc server2:sdb:/dev/sdc'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'ceph-deploy osd activate server0:/dev/sdb1:/dev/sdc server1:/dev/sdb1:/dev/sdc server2:/dev/sdb1:/dev/sdc'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'sudo chmod +r /etc/ceph/ceph.client.admin.keyring'" && \
vagrant ssh server1 -c "sudo su - ceph -c 'sudo chmod +r /etc/ceph/ceph.client.admin.keyring'" && \
vagrant ssh server2 -c "sudo su - ceph -c 'sudo chmod +r /etc/ceph/ceph.client.admin.keyring'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'ceph health'" && \
vagrant ssh server1 -c "sudo su - ceph -c 'ceph status'" && \
vagrant ssh server2 -c "sudo su - ceph -c 'ceph df'" && \
vagrant ssh server1 -c "sudo su - -c 'shutdown -h now'" && \
sleep 30 && \
vagrant ssh server2 -c "sudo su - ceph -c 'ceph status'" && \
CONTROLLER=IDE vagrant up server1 && \
sleep 30 && \
vagrant ssh server1 -c "sudo su - ceph -c 'ceph status'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'ceph-deploy --release luminous client0'" && \
vagrant ssh server0 -c "sudo su - ceph -c 'ceph-deploy admin client0'" && \
vagrant ssh client0 -c "sudo su - ceph -c 'sudo chmod +r /etc/ceph/ceph.client.admin.keyring'" && \
vagrant ssh client0 -c "sudo su - ceph -c 'rbd create rbd0 --size 128 -m server0,server1,server2 -k /etc/ceph/ceph.client.admin.keyring'" && \
vagrant ssh client0 -c "sudo su - ceph -c 'sudo rbd map rbd0 --name client.admin -m server0,server1,server2 -k /etc/ceph/ceph.client.admin.keyring'" && \
vagrant ssh client0 -c "sudo su - -c 'mkfs.xfs -L rbd0 /dev/rbd0'" && \
vagrant ssh client0 -c "sudo su - -c 'mkdir /mnt/rbd0'" && \
vagrant ssh client0 -c "sudo su - -c 'mount /dev/rbd0 /mnt/rbd0'" && \
vagrant destroy -f
