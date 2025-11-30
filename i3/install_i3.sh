#!/bin/bash
SCRIPT_PATH=$PWD
echo "Updating system and reference before starting"
sudo pacman -Syu --noconfirm

echo "installing tools..."
# install stuffs
sudo pacman -S --needed git base-devel --noconfirm && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd ..

yay -S i3-wm sddm kitty neofetch rofi dunst polybar wget curl lsb-release networkmanager network-manager-applet less nm-connection-editor wireless_tools wpa_supplicant bluez bluez-utils plocate git base-devel man dosfstools picom vi vim zsh procs xclip lsd lxappearance thunar noto-fonts noto-fonts-emoji noto-fonts-cjk qt5-graphicaleffects qt5-quickcontrols2 qt5-svg cargo thefuck fd discord firefox xorg-xrandr neovim go timeshift ffmpeg yt-dlp ripgrep bat htop ncdu dust jq python python-pipx arandr autorandr pavucontrol fzf lazygit docker virt-manager vlc ffmpeg yt-dlp flameshot feh obsidian yad xdotool volumeicon smbclient gthumb easyeffects calf lsp-plugins nvidia xcursor-breeze catppuccin-gtk-theme-mocha catppuccin-gtk-theme-macchiato brave-bin ttf-symbola spotify lazydocker pacseek-bin spotdl proton-vpn-gtk-app betterlockscreen xmousepasteblock playerctl jmtpfs btop tldr heroic-games-launcher-bin redshift gvfs bitwarden linux-headers gnome-calculator remmina freerdp libvncserver moonlight-qt colloid-gtk-theme-git gimp libreoffice-still mtpfs ristretto testdisk woeusb-ng yazi zoxide openrazer-daemon gnome-disk-utility --noconfirm


# no idea why it has been installed
sudo pacman -R fontforge

# enable sddm
sudo systemctl enable sddm

# setup theme
sudo mkdir -p /usr/share/sddm/themes
sudo cp $SCRIPT_PATH/others/sddm/sddm.conf /etc
sudo cp -r $SCRIPT_PATH/others/sddm/sugar-candy /usr/share/sddm/themes

# CHANGE SCREENwidth:height WITH THE SIZE SCREEN TO FIT BETTER (1920x1080)
# IN theme.conf
echo "Backuping current config"
if ! [ -d $HOME/.config ]; then
	cp -r -p $HOME/.config $HOME/.config.bak
fi

echo "Installing configs/themes..."
cp -r $SCRIPT_PATH/i3/.config $HOME

# Install font
echo "Installing font..."

sudo mkdir -p /usr/share/fonts/TTF/
sudo cp -r $SCRIPT_PATH/others/fonts/Caskaydia /usr/share/fonts/TTF/
fc-cache

echo "Installing rofi..."
mkdir -p $HOME/.local/share/rofi
cp -r $SCRIPT_PATH/others/rofi/themes $HOME/.local/share/rofi

echo "Installing picom..."
sudo mkdir -p /usr/share/backgrounds/
sudo cp $SCRIPT_PATH/others/picom.conf /etc/xdg/picom.conf

# Install oh-my-zsh
echo "Installing omz..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# add user to plugdev group
echo "Add $USER to plugdev group"
sudo usermod -aG plugdev $USER

systemctl --user enable openrazer-daemon

echo "Don't forget to adapt screen scaled and the title \"headerText\" in /usr/share/sddm/themes/sugar-candy/theme.conf"
echo "select rofi theme with rofi-theme-selector"
echo "select widget theme, cursor, ... with lxappearance"
echo "install steam"
echo "run 'betterlockscreen -u /usr/share/backgrounds/ --display 1' to update betterlockscreen cache"
echo "enable redshift with systemctl --user enable redshift"

echo "for docker on arch with btrfs see https://github.com/egara/arch-btrfs-installation"
sleep 10
reboot
