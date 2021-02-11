# download from somewhere authenticated by rsa key
git clone git@github.com:gunar/commercial-fonts.git
cd commercial-fonts || exit
yes | sudo cp ./*.ttf /usr/share/fonts/TTF/
yes | sudo mkdir -p /usr/share/fonts/OTF/
yes | sudo cp ./*.otf /usr/share/fonts/OTF/
cd ..
rm -rf commercial-fonts
