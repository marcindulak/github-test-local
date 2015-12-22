VBoxManage list dhcpservers && \
VBoxManage dhcpserver modify --disable --netname HostInterfaceNetworking-vboxnet0 && \
git clone https://github.com/marcindulak/vagrant-systemimager-tutorial-centos6.git && \
cd vagrant-systemimager-tutorial-centos6 && \
CLIENT_NO_LVM=y CLIENT_KEXEC=y vagrant up goldenclient server && \
CLIENT_NO_LVM=y vagrant up node101 node102 && \
vagrant ssh node101 -c "sudo su - -c 'ping -I eth1 -c 3 server'" && \
vagrant ssh node101 -c "sudo su - vagrant -c 'sshpass -p vagrant ssh -o StrictHostKeyChecking=no node102 hostname'" && \
vagrant ssh node101 -c '. /etc/profile.d/modules.sh; module load mpich-x86_64; `which mpiexec` -env PYTHONPATH `rpm --eval %python_sitearch`/mpich -iface eth1 --host node101,node102 `rpm --eval %python_sitearch`/mpich/mpi4py/bin/python-mpi -c "from mpi4py import MPI; print MPI.COMM_WORLD.Get_rank()"' && \
vagrant destroy -f
