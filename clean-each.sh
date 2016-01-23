killall VBoxHeadless 2> /dev/null
for interface in `VBoxManage list hostonlyifs | egrep '^Name:' | cut -d: -f2`; do VBoxManage hostonlyif remove $interface; done
for net in `virsh -q net-list | awk '{print $1}'`; do virsh net-destroy $net; done
virsh net-autostart default --disable
for vol in `virsh -q vol-list default | awk '{print $1}'`; do virsh vol-delete $vol default; done
virsh pool-destroy default
virsh pool-undefine default
