git clone https://github.com/marcindulak/VMware-vSphere-Perl-SDK-rpm-centos.git && \
cd VMware-vSphere-Perl-SDK-rpm-centos && \
if test -f /tmp/VMware-vSphere-Perl-SDK-6.0.0-3561779.x86_64.tar.gz; then cp -pf /tmp/VMware-vSphere-Perl-SDK-6.0.0-3561779.x86_64.tar.gz .; fi && \
CENTOSVER=7.2 vagrant up && \
vagrant ssh -c "source /opt/VMware-vSphere-Perl-SDK/bin/VMware-vSphere-Perl-SDK.sh&& vmware-cmd --help" && \
vagrant destroy -f && \
CENTOSVER=6.6 vagrant up && \
vagrant ssh -c "source /opt/VMware-vSphere-Perl-SDK/bin/VMware-vSphere-Perl-SDK.sh&& vmware-cmd --help" && \
vagrant destroy -f
