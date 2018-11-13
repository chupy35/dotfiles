# add font paths
setxkbmap latam
xset fp+ /usr/share/fonts/local 
xset fp default
[[ -d /usr/share/fonts/local ]] && xset +fp /usr/share/fonts/local
[[ -d /usr/share/fonts/OTF ]] && xset +fp /usr/share/fonts/OTF
[[ -d $HOME/.local/share/fonts ]] && xset +fp $HOME/.local/share/fonts
xset fp rehash
xrdb -merge ~/.Xresources
#export VBOX_USB=usbfs

#exec dbus-launch openbox | /home/chupy35/dwm/autostart.sh 
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
export DRI_PRIME=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_AWT_WM_NONREPARENTING=1
#export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel' 
export VDPAU_DRIVER=va_gl
export QT_DEVICE_PIXEL_RATIO=0
export QT_QPA_PLATFORMTHEME=qgnomeplatform 
export GTK2_RC_FILES=$HOME/.gtkrc-2.0

exec /home/chupy35/dwm/dwm-start | /home/chupy35/dwm/autostart.sh 
#exec openbox-session
#exec dbus-launch /home/chupy35/dwm/dwm-start | /home/chupy35/dwm/autostart.sh 

WaylandEnable=false
