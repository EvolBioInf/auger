s=$(which sudo)
if [[ $s == "" ]]; then
    apt update
    apt -y install sudo
fi
h=$(history | tail | grep update)
if [[ $h == "" ]]; then
    sudo apt update
fi
# Install apt packages
sudo apt -y install g++ libdivsufsort-dev libgsl-dev make unzip wget
# Get datasets
wget https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets .
sudo mv datasets /usr/local/bin
# Add macle
git clone https://github.com/evolbioinf/macle
cd macle
make
sudo ln -s $(pwd)/build/* /usr/local/bin
cd ..
# Install latest version of golang
gotar=$(wget -O - https://go.dev/dl/?mode=json |
	    grep -o 'go.*.linux-amd64.tar.gz' |
	    head -n 1) 
wget https://go.dev/dl/$gotar 
sudo tar -C /usr/local -xzf $gotar
export PATH=$PATH:/usr/local/go/bin 
rm $gotar
# Add gin
git clone https://github.com/evolbioinf/gin
cd gin
make
sudo ln -s $(pwd)/bin/* /usr/local/bin
cd ..
# Add biobox
git clone https://github.com/evolbioinf/biobox
cd biobox
make
sudo ln -s $(pwd)/bin/* /usr/local/bin
cd ..
