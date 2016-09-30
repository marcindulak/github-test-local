git clone https://github.com/marcindulak/vagrant-CaltechDelftX-QuCryptox.git && \
cd vagrant-CaltechDelftX-QuCryptox && \
vagrant up && \
vagrant ssh -c "systemctl status IJulia" && \
curl -m 5 -v http://localhost:8890/ && \
vagrant destroy -f
