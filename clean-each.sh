killall VBoxHeadless 2> /dev/null
for interface in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $interface; done
for net in `virsh -q net-list | awk '{print $1}'`; do virsh net-destroy $net; done
