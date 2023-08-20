sudo apt install aptitude
sudo apt install nvidia-<VERSION> nvidia-modprobe clinfo opencl-headers mesa-utils
sudo apt install chromium-browser gparted htop pinta vlc p7zip-rar p7zip-full rar cmake-qt-gui git-cola ncdu unrar
sudo apt install system-config-lvm
sudo apt install scrot feh i3lock kde-spectacle gpicview
sudo apt install mlocate patchelf
sudo updatedb

sudo update-alternatives --set x-www-browser /usr/bin/chromium-browser

sudo aptitude install git python3-pip

# telegram
sudo apt install telegram-desktop

# subl - see https://www.sublimetext.com/docs/linux_repositories.html
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

sudo apt-get install indicator-multiload

sudo aptitude install compizconfig-settings-manager unity-tweak-tool gpointing-device-settings

# sudo lvresize -L +10G local/root
# sudo resize2fs /dev/mapper/local-root

sudo apt-get install openjdk-8-jdk openjdk-8-doc openjdk-8-source 
sudo apt-get install python3-virtualenv

sudo apt-get install i3
sudo pip3 install git+https://github.com/enkore/i3pystatus.git  # http://askubuntu.com/questions/598943/how-to-de-uglify-i3-wm
sudo pip3 install colour psutil netifaces

sudo apt install breeze-icon-theme # it will fix icons f.e. in krusader
sudo apt install kate # text editor used in krusader
sudo apt install krusader

# For old Ubuntu:
# sudo apt-add-repository ppa:maarten-baert/simplescreenrecorder
# sudo apt update
sudo apt install simplescreenrecorder

# xkb-switch (to switch language to latin before screen locking)
git clone https://github.com/grwlf/xkb-switch; cd xkb-switch; git checkout 5dd459ae46aee42dcc395d78a35be664a2a3d8a0
sudo apt install xorg-dev # to fix cmake error "Could NOT find X11"
mkdir build; cd build; cmake ..
sudo make install
cd ../..; rm -rf xkb-switch
# to fix error:
# xkb-switch: error while loading shared libraries: libxkbswitch.so.1: cannot open shared object file: No such file or directory
sudo patchelf --set-rpath '$ORIGIN/../lib' /usr/local/bin/xkb-switch

# to make i3pystatus properly showing cpu term via python sensors module (that uses lm_sensors)
git clone https://github.com/bastienleonard/pysensors
cd pysensors/
git checkout e1ead6b73b2fa14e7baaa855c3e47b078020b4f8
sudo apt install libsensors4-dev
sudo python3 setup.py build_ext --inplace
sudo python3 setup.py install
cd ..
sudo rm -rf pysensors
