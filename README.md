#################################################       INFORMATION  

#######    Configure Gaming Mouse on Linux  
Piper: A GUI tool to manage your gaming mouse on Linux  
		HowTo: https://itsfoss.com/piper-configure-gaming-mouse-linux/  
		https://github.com/libratbag/piper  
  
  
#######     Steering Wheels like Logitech G29  
  https://github.com/berarma/oversteer  
  
  
#######     xpadneo  
               ist ein erweiterter Controller für den Xbox One Wireless Controller  
               + Series X/S Controller  
               + bluetooth  
               wird automatisch installiert, Sektion Downloads  
  
  
#######     Steam Silent Start at boot  
               autostart command to  
	                sh -c "STEAM_FRAME_FORCE_CLOSE=1 steam -silent  
	        or  
	                /usr/bin/steam %U -silent  
               with Manghud auto-enable  
                       sh -c "STEAM_FRAME_FORCE_CLOSE=1 mangohud steam -silent  
  
  
#######     Improve Linux system performance with noatime  
	        https://opensource.com/article/20/6/linux-noatime  
	        sudo vim /etc/fstab  
	        add after each ext4 noatime  
	        ext4   defaults,noatime,****  
   
  
#######     Thunderbird Systray  
               https://github.com/Ximi1970/systray-x/releases  
   
  
#######     ASUS Xonar DGX  
               terminal -> alsamixer -> F6 -> change Analog Outpu to Stereo Headphones, not MultiChannel or Stereo HeadphonesFP  
               esc  
               save status:  
               alsactl --file ~/.config/alsamixer/asound.state store  
               import:  
       a       lsactl --file ~/.config/alsamixer/asound.state restore  
  
  
#######     Equalizer für Audio  
               PulseEffects(sys) oder EasyEffects(flatpak)  
               Extremst wichtig für Headset    !!!  
  
  
#######     Theme / Darkmode Probleme  
               Programstarter bearbeiten  
               env GTK_THEME=Adwaita (oder andere) vor den Befehl setzen  
               Bsp: env GTK_THEME=Adwaita sh /opt/jameica/jameica.sh  
               Bsp: env GTK_THEME=Adwaita firefox %u  
  
  
#######	Virtualization using KVM + QEMU + libvirt  
		HowTo: https://www.dwarmstrong.org/kvm-qemu-libvirt/  
		$ sudo apt install qemu-system-x86 libvirt-clients libvirt-daemon libvirt-daemon-system virtinst virt-manager bridge-utils  
  
#######     Schnipsel  
               JAVA -> Default 11  
               sudo apt install default-jre openjdk-21-jre  
               sudo update-alternatives --config java  
               paprefs -> Simultan Audio Output  
		pulseaudio-equalizer	https://gist.github.com/leogama/35961ec0d279e6cf409f783c3851569e https://askubuntu.com/questions/980876/how-do-i-start-pulseaudio-equalizer https://wiki.ubuntuusers.de/PulseAudio/  
		pulseaudio-equalizer	https://forums.linuxmint.com/viewtopic.php?t=352113  
  
  
#######     DXVK Vulkan  
               https://github.com/doitsujin/dxvk  
  
#################################################
