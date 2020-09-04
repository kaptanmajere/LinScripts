#!/bin/sh
# NOTES : 
# Minimal installation stable - generic - hwe kernel ,Disable autoupdates and sources , never dist-upgrade

### Install linux 18.04 Desktop 64 bit  |minimal install ###
#open /etc/apt/sources.list
#remove # from sources
sudo apt-get update
sudo apt-get upgrade

# MINI (minimal install cd - sever) AND DESKTOP VERSION
sudo apt-get -y install openssh-server net-tools nmap
sudo apt-get -y install tcpdump iptraf-ng wondershaper ifenslave net-tools whois isc-dhcp-server openssh-server sshfs
sudo apt-get -y install qemu virt-manager 
sudo apt-get -y install gdebi synaptic pv curl git pigz rar unrar ntpdate mesa-utils cpufrequtils zip
sudo apt-get -y install htop iotop powertop lm-sensors hwinfo phoronix-test-suite sysbench
sudo apt-get -y install dmraid mdadm samba samba-client bcache-tools dislocker dstat smartmontools testdisk 
sudo apt-get -y install nodejs npm python python-pip python3 python3-pip  python-dev

sudo pip3 install --upgrade pip
pip3 install jupyter notebook
pip3 install ipython
pip install click request 
PATH=$PATH:/home/gediz/.local/bin:

sudo apt-get -y install cpufrequtils
sudo systemctl disable ondemand
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# System waits network and does not trigger rc.local ...
systemctl disable systemd-networkd-wait-online.service
systemctl mask systemd-networkd-wait-online.service


# WEBMIN INSTALLATION
sudo apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.930_all.deb
dpkg --install webmin_1.930_all.deb
install vm-ware tools # optional


# MINIMAL GUI for MINI
sudo apt-get -y --no-install-recommends install xubuntu-desktop
sudo apt-get -y install gparted psensor

# FOR REMOTE DESKTOP CONNECTIONS 

sudo apt-get --no-install-recommends install xubuntu-desktop
# apply scripts at https://www.hiroom2.com/2018/05/07/ubuntu-1804-xrdp-xfce-en/
# xubuntu-desktopı çek ama recommend ettiği application ve kütüphaneleri çekme minumum installa 
sudo apt install -y xrdp # xrdp yi yes diye sormadan installa
sudo sed -e 's/^new_cursors=true/new_cursors=false/g' \
           -i /etc/xrdp/xrdp.ini # xrdpi ini dosyasında new_cursors ayarını disable et 
sudo systemctl enable xrdp
sudo systemctl restart xrdp
# xrdp servisini yeniden başlat

echo "xfce4-session" > ~/.xsession
#xfce4 ü login sessionlar listesine ekle (xubuntu distrosunun nun dekstop ı çizen kısmı başlı başına bir desktop window manager)
D=/usr/share/xfce4:/usr/share/xubuntu:/usr/local/share
D=${D}:/usr/share:/var/lib/snapd/desktop:/usr/share
#user folderları D de topla : ile ayır aynı PATH gibi 

cat <<EOF > ~/.xsessionrc
# EOF gelene kadar bunları cat' e yolla ekrana yazsın EOF gelince birikeni .xsessionrc ye yazsın 
export XDG_SESSION_DESKTOP=xubuntu
export XDG_DATA_DIRS=${D}
export XDG_CONFIG_DIRS=/etc/xdg/xdg-xubuntu:/etc/xdg:/etc/xdg
# üstteki XDG ayarları desktop sessiondaki user folder ayarları

EOF
sudo cp /usr/bin/light-locker /usr/bin/light-locker.orig
cat <<EOF | sudo tee /usr/bin/light-locker
#!/bin/sh
# The light-locker uses XDG_SESSION_PATH provided by lightdm.
if [ ! -z "\${XDG_SESSION_PATH}" ]; then
  /usr/bin/light-locker.orig
else
  # Disable light-locker in XRDP.
  true
fi
EOF
# üstteki gibi (EOF) XRDP kullanılırken light-locker yani ekran kilitlemeyi disable et 

sudo chmod a+x /usr/bin/light-locker

# ADDITIONAL INSTALLATIONS FOR DESKTOP VERSION
sudo apt-get -y install cinnamon-desktop-environment
sudo apt-get -y install blender audacity ffmpeg vlc gparted adb
sudo apt-get -y purge ubuntu-session gnome-session gdm3 ubuntu-desktop plymouth-theme-ubuntu-text snapd xwayland 
# Remove options from cd /usr/share/xsessions
sudo apt-get -y install linux-tools-common obs-studio remmina
sudo add-apt-repository ppa:daniruiz/flat-remix -y
sudo add-apt-repository ppa:gezakovacs/ppa -y
sudo apt-get update
sudo apt-get -y install flat-remix

# Droid mote remote control mouse from cell phone 
curl -Ls https://www.videomap.it/script/install_droidmote_ubuntu.sh | sudo sh

# GUI SETTINGS 

#themes -> adapta-nokto
#font -> text scaling 0.9 , window title font -> 9 --- Hinting medium antialiasing Rgba
#terminal - gedit solarized dark & -> text-color:#9DE7FF background-color:#112639
#select flat-remix-blue-dark from themes-icons
#edit launcher google-chrome --force-device-scale-factor=0.80
#chrome zoom to 100 (leav it)
#set cinnamon panel scale smallest + 1 tick
#desktop icons font scale smaller (right click desktop -> iconsize -> smaller
#terminal font - gedit font force use monospace 10
#adjust list view 


#/////////////////////////ADDITIONAL INSTALLATIONS //////////////////////////
### amdgpu opensource driver support ###
#GRUB_CMDLINE_LINUX_DEFAULT="quiet radeon.si_support=0 radeon.cik_support=0 amdgpu.si_support=1 amdgpu.cik_support=1 #amdgpu.dc=1 amdgpu.modeset=1"

# NVIDIA Cuda cuda-repo-ubuntu1804-10-2-local-XXXXXXXXX_amd64
# install chrome - visual studio code - vmware - Unigine Superposition - dropbox - teamviewer -- rocm ? - vulkan ? 
# install geekbench - lutris - dvdk 

#///////////////////////////////////////////////////
#TODO //
#Disable unattanded upgrades (software and updates gui or sudo nano /etc/apt/apt.conf.d/20auto-upgrades)

#NOTES:

