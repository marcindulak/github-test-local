cd ~/github/test
rm -rfv irods-tutorial-centos6
git clone https://github.com/marcindulak/irods-tutorial-centos6.git
cd irods-tutorial-centos6/vagrant
vagrant up
vagrant ssh client1 -c "sudo su - vagrant -c 'mkdir -p ~/.irods'"
vagrant ssh client1 -c "sudo su - vagrant -c 'cp /vagrant/vagrant/.irods/irods_environment.json ~/.irods'"
vagrant ssh client1 -c "sudo su - vagrant -c 'ienv'"
vagrant ssh client1 -c "sudo su - vagrant -c 'echo vagrant | iinit'"
vagrant ssh client1 -c "sudo su - vagrant -c 'ils'"
vagrant ssh client1 -c "sudo su - vagrant -c 'echo 1 > testfile'"
vagrant ssh client1 -c "sudo su - vagrant -c 'iput testfile'"
vagrant ssh client1 -c "sudo su - vagrant -c 'ils'"
vagrant ssh client1 -c "sudo su - vagrant -c 'irm testfile'"
vagrant ssh client1 -c "sudo su - vagrant -c 'ils'"
vagrant destroy -f
