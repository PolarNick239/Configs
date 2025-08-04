# Install NVIDIA driver via .run from https://www.nvidia.com/en-us/geforce/drivers/
# Choose MIT/GPL kernel module type (instead of NVIDIA Proprietary), otherwise in case of NVIDIA 5070Ti in Xorg.0.log:
# (EE) NVIDIA(GPU-0): The NVIDIA GPU at PCI:1:0:0 is not supported by the 580.65.06

sudo apt install clinfo
sudo apt install chromium-browser gparted htop vlc p7zip-rar p7zip-full rar ncdu unrar
sudo snap install krita
sudo apt install system-config-lvm
sudo apt install scrot feh i3lock kde-spectacle gpicview
sudo apt install plocate patchelf
sudo updatedb

sudo update-alternatives --set x-www-browser /usr/bin/chromium-browser

sudo apt install git cmake python3-pip python3.12-virtualenv

# telegram
sudo snap install telegram-desktop

sudo snap install obsidian --classic

sudo apt install indicator-multiload

# sudo aptitude install compizconfig-settings-manager unity-tweak-tool gpointing-device-settings

# sudo lvresize -L +10G local/root
# sudo resize2fs /dev/mapper/local-root

# sudo apt-get install openjdk-8-jdk openjdk-8-doc openjdk-8-source 

sudo apt install i3

python3 -mvenv ~/.config/i3pystatus-venv
source ~/.config/i3pystatus-venv/bin/activate
pip install git+https://github.com/enkore/i3pystatus.git  # http://askubuntu.com/questions/598943/how-to-de-uglify-i3-wm
pip install colour psutil netifaces
deactivate

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
sudo apt install libsensors-dev
source ~/.config/i3pystatus-venv/bin/activate
sudo python3 setup.py build_ext --inplace
sudo python3 setup.py install
deactivate
cd ..
sudo rm -rf pysensors
