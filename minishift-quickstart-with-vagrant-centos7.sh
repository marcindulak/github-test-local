git clone https://github.com/marcindulak/minishift-quickstart-with-vagrant-centos7.git && \
cd minishift-quickstart-with-vagrant-centos7 && \
vagrant plugin install vagrant-libvirt && \
vagrant up --no-parallel && \
vagrant ssh minishift -c "sudo su - -c 'yum -y install wget git'" && \
vagrant ssh minishift -c "sudo su - -c 'wget -q https://copr.fedorainfracloud.org/coprs/marcindulak/minishift/repo/fedora-rawhide/marcindulak-minishift-fedora-rawhide.repo -P /etc/yum.repos.d'" && \
vagrant ssh minishift -c "sudo su - -c 'yum -y install minishift'" && \
vagrant ssh minishift -c "sudo su - -c 'yum -y install yum-utils device-mapper-persistent-data lvm2'" && \
vagrant ssh minishift -c "sudo su - -c 'yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo'" && \
vagrant ssh minishift -c "sudo su - -c 'yum -y install docker-ce'" && \
vagrant ssh minishift -c "sudo su - -c 'mkdir -p /etc/docker&& echo { \\\"storage-driver\\\": \\\"devicemapper\\\" } > /etc/docker/daemon.json'" && \
vagrant ssh minishift -c "sudo su - -c 'systemctl start docker'" && \
vagrant ssh minishift -c "sudo su - -c 'docker run hello-world'" && \
vagrant ssh minishift -c "sudo su - -c 'systemctl enable docker'" && \
vagrant ssh minishift -c "sudo su - -c 'curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 > /usr/local/bin/docker-machine-driver-kvm&& chmod +x /usr/local/bin/docker-machine-driver-kvm'" && \
vagrant ssh minishift -c "sudo su - -c 'yum -y install libvirt qemu-kvm'" && \
vagrant ssh minishift -c "sudo su - -c 'systemctl start libvirtd'" && \
vagrant ssh minishift -c "sudo su - -c 'systemctl enable libvirtd'" && \
vagrant ssh minishift -c "sudo su - -c 'usermod -aG libvirt vagrant'" && \
vagrant ssh minishift -c "sudo su - -c 'yum -y install konqueror xorg-x11-fonts-Type1 && reboot'" && \
sleep 30 && \
vagrant ssh minishift -c "sudo su - -c 'systemctl is-active docker'" && \
vagrant ssh minishift -c "sudo su - -c 'systemctl is-active libvirtd'" && \
vagrant ssh minishift -c "minishift start --cpus=2 --memory=2048 --vm-driver=kvm" && \
vagrant ssh minishift -c "minishift oc-env" && \
vagrant ssh minishift -c 'eval $(minishift oc-env) && oc new-app https://github.com/openshift/nodejs-ex -l name=myapp' && \
vagrant ssh minishift -c 'eval $(minishift oc-env) && oc logs -f bc/nodejs-ex' && \
vagrant ssh minishift -c 'eval $(minishift oc-env) && oc expose svc/nodejs-ex' && \
! timeout 30 vagrant ssh minishift -c 'minishift openshift service nodejs-ex -n myproject' -- -X && \
vagrant ssh minishift -c 'minishift stop' && \
vagrant destroy -f
