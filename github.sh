rm -rf ~/VirtualBox\ VMs/*
rm -rf ~/.vagrant.d/boxes/*
killall VBoxHeadless 2> /dev/null
STATUS='OK'
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-hadoop-hortonworks-tutorial-centos7.sh > ~/github/vagrant-hadoop-hortonworks-tutorial-centos7.log 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-hadoop-hortonworks-tutorial-centos7.log -s 'github FAIL: vagrant-hadoop-hortonworks-tutorial-centos7' ${EMAIL}; STATUS='FAIL'; fi
#
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-ceph-rbd-tutorial-centos7.sh > ~/github/vagrant-ceph-rbd-tutorial-centos7.log 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-ceph-rbd-tutorial-centos7.log -s 'github FAIL: vagrant-ceph-rbd-tutorial-centos7' ${EMAIL}; STATUS='FAIL'; fi
#
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
virsh net-destroy vagrant-opennebula-tutorial-centos70
sh ~/github/vagrant-opennebula-tutorial-centos7.sh > ~/github/vagrant-opennebula-tutorial-centos7.log 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-opennebula-tutorial-centos7.log -s 'github FAIL: vagrant-opennebula-tutorial-centos7' ${EMAIL}; STATUS='FAIL'; fi
#
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-systemimager-tutorial-centos6.sh > ~/github/vagrant-systemimager-tutorial-centos6.log 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-systemimager-tutorial-centos6.log -s 'github FAIL: vagrant-systemimager-tutorial-centos6' ${EMAIL}; STATUS='FAIL'; fi
#
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/irods-tutorial-centos6.sh > ~/github/irods-tutorial-centos6.log 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/irods-tutorial-centos6.log -s 'github FAIL: irods-tutorial-centos6' ${EMAIL}; STATUS='FAIL'; fi
#
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-lustre-tutorial.sh > ~/github/vagrant-lustre-tutorial.log 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-lustre-tutorial.log -s 'github FAIL: vagrant-lustre-tutorial' ${EMAIL}; STATUS='FAIL'; fi
#
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-xymon-tutorial.sh > ~/github/vagrant-xymon-tutorial.log 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-xymon-tutorial.log -s 'github FAIL: vagrant-xymon-tutorial' ${EMAIL}; STATUS='FAIL'; fi
#
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-munin-tutorial.sh > ~/github/vagrant-munin-tutorial.log 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-munin-tutorial.log -s 'github FAIL: vagrant-munin-tutorial' ${EMAIL}; STATUS='FAIL'; fi
#
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/puppet-nagios.sh > ~/github/puppet-nagios.log 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/puppet-nagios.log -s 'github FAIL: puppet-nagios' ${EMAIL}; STATUS='FAIL'; fi
#
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/Clusters_From_Scratch-1.1-pcs-Fedora-21.sh > ~/github/Clusters_From_Scratch-1.1-pcs-Fedora-21.log 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/Clusters_From_Scratch-1.1-pcs-Fedora-21.log -s 'github FAIL: Clusters_From_Scratch-1.1-pcs-Fedora-21' ${EMAIL}; STATUS='FAIL'; fi
#
if [ "${STATUS}" = "OK" ];
then
echo | mailx -s 'github OK' ${EMAIL}
fi

