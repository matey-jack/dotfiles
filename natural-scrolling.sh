# you need to adapt this script by running commands manually to find IDs, then add them here
xinput list  # find your mouse
xinput list-props  # find any relevant property like "Natural Scrolling" or "Scrolling Distance" 
xinput set-prop

# I ran this in my .bashrc, which was good enough since I also open a terminal before doing anything else on the PC
# surely, there must be ways to run it already on login...

# https://askubuntu.com/a/907845 says that one could try to install either of those packages:
# xserver-xorg-input-libinput vs xserver-xorg-input-synaptics
# but beware: some people lost their keyboard driver this way and couldn't login any more afterward ==:->

