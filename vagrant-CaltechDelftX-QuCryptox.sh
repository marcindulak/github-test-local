git clone https://github.com/marcindulak/vagrant-CaltechDelftX-QuCryptox.git && \
cd vagrant-CaltechDelftX-QuCryptox && \
vagrant up && \
vagrant ssh -c "systemctl status IJulia" && \
curl -v https://localhost:8890/ && \
vagrant destroy -f
