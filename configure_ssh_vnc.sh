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
autoreconf -fiv
./configure
make
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
