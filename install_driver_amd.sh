# Install 5.4.0 kernel
sudo apt install linux-generic
# Reboot and choose 5.4.0 kernel
sudo reboot now

# Ensure that 5.4.0 kernel is used
uname -a
# List installed kernels
dpkg --list | grep "ii.*linux-image"
# Remove all kernels except 5.4.0:
KVERSION=5.13.0-30
sudo apt remove linux-modules-extra-${KVERSION}-generic linux-modules-${KVERSION}-generic linux-headers-${KVERSION}-generic linux-image-${KVERSION}-generic
KVERSION=5.15.0-46
sudo apt remove linux-modules-extra-${KVERSION}-generic linux-modules-${KVERSION}-generic linux-headers-${KVERSION}-generic linux-image-${KVERSION}-generic

wget --referer https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-20-50 https://drivers.amd.com/drivers/linux/amdgpu-pro-20.50-1234664-ubuntu-20.04.tar.xz
tar -xvf amdgpu-pro-20.50-1234664-ubuntu-20.04.tar.xz
cd amdgpu-pro-20.50-1234664-ubuntu-20.04/
./amdgpu-install -y --opencl=legacy,pal
sudo usermod -a -G render $LOGNAME
sudo usermod -a -G video $LOGNAME
sudo apt-get install clinfo
clinfo

# See also
# https://support.zivid.com/en/latest/getting-started/software-installation/gpu/amd-driver-ubuntu.html
# https://www.reddit.com/r/gpumining/comments/ptmyjd/ubuntu_20043_amdgpu_2130_opencl_rocr_rocm/
# https://www.reddit.com/r/linuxquestions/comments/tgqpme/struggling_to_install_amd_pro_drivers_on_ubuntu/
# https://askubuntu.com/questions/1336913/opencl-not-working-with-rx-6700-xt
