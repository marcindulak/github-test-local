killall VBoxHeadless 2> /dev/null
for interface in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $interface; done
for net in `virsh -q net-list -all | awk '{print $1}'`; do virsh net-destroy $net; done
virsh net-autostart default --disable
for pool in `virsh -q pool-list | awk '{print $1}'`; do virsh pool-destroy $pool; virsh pool-undefine $pool; done
for guest in `virsh -q list --inactive | awk '{print $2}'`; do virsh undefine $guest; done
