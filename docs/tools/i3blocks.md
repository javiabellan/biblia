# i3


1. Poner en .config/i3/config en bar

status_command i3blocks
status_command i3blocks -c /home/javi/.i3/.i3blocks

height 18

2. Editar configuración:

subl /etc/i3blocks.conf

3. Scrips en /usr/lib/i3blocks




## Config


```bash
######################################################## VARIABLES

# Mod key
# set $mod Mod1 (alt)
set $mod Mod4

# Apps
set $browser   firefox
set $music     spotify
set $term      urxvt


########################################################  i3-gaps

# Gaps
set $inner 32
set $outer 16

gaps inner $inner
gaps outer $outer

bindsym $mod+plus     gaps inner current minus 8
bindsym $mod+minus    gaps inner current plus  8

# Hide window top bar
for_window [class="^.*"] border pixel 3

#hide_edge_borders both


######################################################## FONT

# Font for window titles.
# Will also be used by the bar unless a different font is used in the bar {} block below.
#font pango:monospace 8
font pango:monaco 8

# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
#font pango:DejaVu Sans Mono 8

# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn’t scale on retina/hidpi displays.


######################################################## FLOATING

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod


######################################################## SHORTCUTS

# start a terminal
bindsym $mod+Return exec i3-sensible-terminal

# kill focused window
bindsym $mod+q kill
bindsym $mod+Shift+q kill

# Menu
# start dmenu (a program launcher)
#bindsym $mod+d exec dmenu_run
#bindsym $mod+m exec dmenu_run
bindsym $mod+space exec rofi -show run

# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop


bindsym $mod+Tab        workspace back_and_forth

######################################################## MOVEMENT

# FOCUS
#bindsym $mod+j      focus left
#bindsym $mod+k      focus down
#bindsym $mod+l      focus up
#bindsym $mod+ntilde focus right
bindsym $mod+Left    focus left
bindsym $mod+Down    focus down
bindsym $mod+Up      focus up
bindsym $mod+Right   focus right

# MOVE FOCUSED
#bindsym $mod+Shift+j      move left
#bindsym $mod+Shift+k      move down
#bindsym $mod+Shift+l      move up
#bindsym $mod+Shift+ntilde move right
bindsym $mod+Shift+Left    move left
bindsym $mod+Shift+Down    move down
bindsym $mod+Shift+Up      move up
bindsym $mod+Shift+Right   move right

# HORIZONTAL SPLIT
bindsym $mod+h split h

# VERTICAL SPLIT
bindsym $mod+v split v

# FULLSCREEN
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
# bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child


################################################################ WORKSPACES

# Workspaces
set $ws1  "1: Terminals"
set $ws2  "2: Internet"
set $ws3  "3"
set $ws4  "4"
set $ws5  "5"
set $ws6  "6"
set $ws7  "7"
set $ws8  "8"
set $ws9  "9"
set $ws10 "10: Music"

# switch to workspace
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+0 workspace $ws10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5
bindsym $mod+Shift+6 move container to workspace $ws6
bindsym $mod+Shift+7 move container to workspace $ws7
bindsym $mod+Shift+8 move container to workspace $ws8
bindsym $mod+Shift+9 move container to workspace $ws9
bindsym $mod+Shift+0 move container to workspace $ws10


################################################################ COLORS

# class                 border  backgr. text    indicator child_border
client.focused          #4c7899 #285577 #ffffff #2e9ef4   #285577
client.focused_inactive #333333 #5f676a #ffffff #484e50   #5f676a
client.unfocused        #333333 #222222 #888888 #292d2e   #222222
client.urgent           #2f343a #900000 #ffffff #900000   #900000
client.placeholder      #000000 #0c0c0c #ffffff #000000   #0c0c0c

client.background       #ffffff



# reload the configuration file
bindsym $mod+Shift+c reload

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym ntilde resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

################################################################ i3bar

bar {
	# STATUS
	# DEFUALT: i3status
	#status_command i3status
	status_command i3blocks

	# Show on top
	position top

	mode dock
	modifier None
}




################################################################ CUSTOM


# lock
bindsym $mod+l exec i3lock


################################################################ INIT APPS


assign [class="Navigator"] $ws2
 exec firefox

# only on restart and login
# exec firefox
#
# every time that i3 is loaded
# exec_always

# background
exec_always --no-startup-id feh --bg-scale /home/javi/Imágenes/fondos/space1.jpg


################################################################ MULTIMEDIA KEYS

# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound

# Sreen brightness controls
# bindsym XF86MonBrightnessUp exec xbacklight -inc 20 # increase screen brightness
# bindsym XF86MonBrightnessDown exec xbacklight -dec 20 # decrease screen brightness

# Touchpad controls
# bindsym XF86TouchpadToggle exec /some/path/toggletouchpad.sh # toggle touchpad

# Media player controls
bindsym XF86AudioPlay exec playerctl play
bindsym XF86AudioPause exec playerctl pause
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous
```