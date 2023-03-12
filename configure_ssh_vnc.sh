# Target System:

# SSH
sudo apt install openssh-server -y
sudo nano /etc/ssh/sshd_config # change port to ${ssh_port}
sudo systemctl restart ssh
sudo systemctl status ssh
sudo ufw allow ${ssh_port}/tcp
sudo ufw enable && sudo ufw reload

# X11VNC
sudo apt build-dep x11vnc # may require to enable repos in GUI - https://askubuntu.com/a/857433
git clone https://github.com/LibVNC/x11vnc
cd x11vnc
git checkout 0c4fbc3cf69471bc1288a5f8d2a218e798d01cff

# IF with TurboJPEG + TurboVNC:
# https://github.com/LibVNC/x11vnc/blob/master/doc/FAQ.md#q-80-does-x11vnc-support-turbovnc
# https://github.com/LibVNC/x11vnc/blob/master/misc/turbovnc/README
cd ..
git clone https://github.com/LibVNC/libvncserver
cd libvncserver
git checkout 111db4bea124af27986c665dabd30c290168bb3d
cp src/libvncserver/* . # we need tight.c and rfbserver.c
cd ../x11vnc/misc/turbovnc
./apply_turbovnc
cd ../..
sudo apt install libturbojpeg
autoreconf -fiv
env LDFLAGS='-L/usr/lib/x86_64-linux-gnu/ -Xlinker --rpath=/usr/lib/x86_64-linux-gnu/' ./configure
make AM_LDFLAGS='-lturbojpeg'
# IFELSE without TurboJPEG + TurboVNC:
#autoreconf -fiv
#./configure
#make
sudo make install
cd ..
rm -rf x11vnc
sudo ufw allow ${vnc_port}/tcp # 5900 by default
sudo ufw enable && sudo ufw reload

DISPLAY=:0 x11vnc -usepw -noncache -wait 5 -defer 5



# Client System:

# TurboVNC
wget https://sourceforge.net/projects/turbovnc/files/2.1.1/turbovnc_2.1.1_amd64.deb/download -O turbovnc_2.1.1_amd64.deb
sudo dpkg -i turbovnc*.deb
rm turbovnc*.deb

/opt/TurboVNC/bin/vncviewer ${ip}

# Remmina for RDP
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret
