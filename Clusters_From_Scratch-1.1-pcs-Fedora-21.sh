cd ~/github/test && \
rm -rfv Clusters_From_Scratch-1.1-pcs && \
git clone https://github.com/marcindulak/Clusters_From_Scratch-1.1-pcs.git && \
cd Clusters_From_Scratch-1.1-pcs && \
vagrant up && \
vagrant destroy -f
