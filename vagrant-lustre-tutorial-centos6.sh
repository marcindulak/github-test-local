git clone https://github.com/marcindulak/vagrant-lustre-tutorial-centos6.git && \
cd vagrant-lustre-tutorial-centos6 && \
vagrant up mds01 && sleep 10 && vagrant reload mds01 && \
vagrant up mds02 && sleep 10 && vagrant reload mds02 && \
vagrant up oss01 && sleep 10 && vagrant reload oss01 && \
vagrant up oss02 && sleep 10 && vagrant reload oss02 && \
vagrant up centos7 && vagrant reload centos7 && \
vagrant ssh centos7 -c "sudo su -c 'lctl dl'" && \
vagrant ssh centos7 -c "sudo su -c 'lfs osts'" && \
vagrant ssh centos7 -c "sudo su -c 'dd if=/dev/zero of=/lustre/testfile bs=1M count=512'" && \
vagrant ssh centos7 -c "sudo su -c 'lfs getstripe /lustre'" && \
vagrant ssh centos7 -c "sudo su -c 'lfs find  /lustre -type f -print'" && \
vagrant ssh centos7 -c "sudo su -c 'lfs df -h'" && \
vagrant ssh centos7 -c "sudo su -c 'rm -f /lustre/testfile'" && \
vagrant ssh centos7 -c "sudo su -c 'mkdir /lustre/stripe_2'" && \
vagrant ssh centos7 -c "sudo su -c 'lfs setstripe -c 2 /lustre/stripe_2'" && \
vagrant ssh centos7 -c "sudo su -c 'dd if=/dev/zero of=/lustre/stripe_2/testfile bs=1M count=512'" && \
vagrant ssh centos7 -c "sudo su -c 'lfs getstripe /lustre/stripe_2/testfile'" && \
vagrant ssh centos7 -c "sudo su -c 'rm -rf /lustre/stripe_2'" && \
vagrant ssh centos7 -c "sudo su -c 'wget https://github.com/chaos/ior/archive/3.0.1.tar.gz -O ior-3.0.1.tar.gz'" && \
vagrant ssh centos7 -c "sudo su -c 'tar zxf ior-3.0.1.tar.gz'" && \
vagrant ssh centos7 -c "sudo su -c 'yum -y install automake'" && \
vagrant ssh centos7 -c "sudo su -c 'cd ior-3.0.1; sh bootstrap'" && \
vagrant ssh centos7 -c "sudo su -c 'yum -y install openmpi-devel'" && \
vagrant ssh centos7 -c "sudo su -c '. /etc/profile.d/modules.sh; module load mpi; cd ior-3.0.1; ./configure'" && \
vagrant ssh centos7 -c "sudo su -c '. /etc/profile.d/modules.sh; module load mpi; cd ior-3.0.1; make'" && \
vagrant ssh centos7 -c "sudo su -c '. /etc/profile.d/modules.sh; module load mpi; mpirun --allow-run-as-root -np 1 --map-by node ior-3.0.1/src/ior -v -a POSIX -i5 -g -e -w -r 512m -b 4m -o /lustre/testfile -F -C -b 256k -t 4k -O lustreStripeCount=1 -z random'" && \
vagrant up centos6 && vagrant reload centos6 && \
vagrant ssh centos6 -c "sudo su -c 'lfs df -h'" && \
vagrant ssh centos6 -c "sudo su -c 'mkdir /lustre/vagrant'" && \
vagrant ssh centos6 -c "sudo su -c 'chown vagrant.vagrant /lustre/vagrant'" && \
vagrant ssh centos6 -c "sudo su - vagrant -c 'touch /lustre/vagrant/testfile'" && \
vagrant ssh oss02 -c "sudo su -c 'umount /lustre/ost02'" && \
vagrant ssh oss01 -c "sudo su -c 'echo \"/dev/sdc /lustre/ost02 lustre defaults 0 0\" >> /etc/fstab'" && \
vagrant ssh oss01 -c "sudo su -c 'mkdir -p /lustre/ost02'" && \
vagrant ssh oss01 -c "sudo su -c 'mount /lustre/ost02'" && \
vagrant ssh centos7 -c "sudo su -c 'lfs df -h'" && \
vagrant destroy -f
