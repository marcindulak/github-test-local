rm -rf ~/VirtualBox\ VMs/*
rm -rf ~/.vagrant.d/boxes/*
rm -rf ~/github/test
mkdir ~/github/test
cd ~/github/test
STATUS='OK'
killall VBoxHeadless 2> /dev/null
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-hadoop-hortonworks-tutorial-centos7.sh > ~/github/vagrant-hadoop-hortonworks-tutorial-centos7.txt 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-hadoop-hortonworks-tutorial-centos7.txt -s 'github FAIL: vagrant-hadoop-hortonworks-tutorial-centos7' ${EMAIL}; STATUS='FAIL'; fi
#
killall VBoxHeadless 2> /dev/null
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-ceph-rbd-tutorial-centos7.sh > ~/github/vagrant-ceph-rbd-tutorial-centos7.txt 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-ceph-rbd-tutorial-centos7.txt -s 'github FAIL: vagrant-ceph-rbd-tutorial-centos7' ${EMAIL}; STATUS='FAIL'; fi
#
killall VBoxHeadless 2> /dev/null
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
virsh net-destroy vagrant-opennebula-tutorial-centos70
sh ~/github/vagrant-opennebula-tutorial-centos7.sh > ~/github/vagrant-opennebula-tutorial-centos7.txt 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-opennebula-tutorial-centos7.txt -s 'github FAIL: vagrant-opennebula-tutorial-centos7' ${EMAIL}; STATUS='FAIL'; fi
#
killall VBoxHeadless 2> /dev/null
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-systemimager-tutorial-centos6.sh > ~/github/vagrant-systemimager-tutorial-centos6.txt 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-systemimager-tutorial-centos6.txt -s 'github FAIL: vagrant-systemimager-tutorial-centos6' ${EMAIL}; STATUS='FAIL'; fi
#
killall VBoxHeadless 2> /dev/null
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/irods-tutorial-centos6.sh > ~/github/irods-tutorial-centos6.txt 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/irods-tutorial-centos6.txt -s 'github FAIL: irods-tutorial-centos6' ${EMAIL}; STATUS='FAIL'; fi
#
killall VBoxHeadless 2> /dev/null
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-lustre-tutorial.sh > ~/github/vagrant-lustre-tutorial.txt 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-lustre-tutorial.txt -s 'github FAIL: vagrant-lustre-tutorial' ${EMAIL}; STATUS='FAIL'; fi
#
killall VBoxHeadless 2> /dev/null
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-xymon-tutorial.sh > ~/github/vagrant-xymon-tutorial.txt 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-xymon-tutorial.txt -s 'github FAIL: vagrant-xymon-tutorial' ${EMAIL}; STATUS='FAIL'; fi
#
killall VBoxHeadless 2> /dev/null
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/vagrant-munin-tutorial.sh > ~/github/vagrant-munin-tutorial.txt 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/vagrant-munin-tutorial.txt -s 'github FAIL: vagrant-munin-tutorial' ${EMAIL}; STATUS='FAIL'; fi
#
killall VBoxHeadless 2> /dev/null
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/puppet-nagios.sh > ~/github/puppet-nagios.txt 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/puppet-nagios.txt -s 'github FAIL: puppet-nagios' ${EMAIL}; STATUS='FAIL'; fi
#
killall VBoxHeadless 2> /dev/null
for i in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $i; done
sh ~/github/Clusters_From_Scratch-1.1-pcs-Fedora-21.sh > ~/github/Clusters_From_Scratch-1.1-pcs-Fedora-21.txt 2>&1
if ! test $? -eq 0; then echo | mailx -A ~/github/Clusters_From_Scratch-1.1-pcs-Fedora-21.txt -s 'github FAIL: Clusters_From_Scratch-1.1-pcs-Fedora-21' ${EMAIL}; STATUS='FAIL'; fi
#
if [ "${STATUS}" = "OK" ];
then
echo | mailx -s 'github OK' ${EMAIL}
fi

