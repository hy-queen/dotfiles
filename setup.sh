#!/bin/bash

# Setup includes:
# DM: SDDM Sugar Candy
# WM: i3-gaps
# Terminal: Kitty
# Status bar: polybar
# Compositor: picom ibhagwan
# App menu and power menu: Rofi
# Font: Fira Code and Quicksand 
# Lock screen: i3lock-color| Yet to configure
#Shell: zsh/oh-my-zsh

echo -n "Ubuntu or Arch? [U/A] "
read DISTRO
DISTRO="`echo ${DISTRO:0:1} | awk '{print tolower($0)}'`"
#---------------------U B U N T U----------------------#
if [ "$DISTRO" == "u" ]; then
	echo "Ubuntu"
	exit
#----------------------A R C H--------------------------#
elif [ "$DISTRO" == "a" ]; then
	mkdir .packages && cd .packages

	echo "Installing terminal..."
	sudo pacman -S --needed kitty
	sudo pacman -S --needed zsh
	
	echo "Installing Yay..."
	sudo pacman -S --needed base-devel &>/dev/null
	git clone https//aur.archlinux.org/yay.git &>/dev/null
	cd yay
	makepkg -si
	
	echo "Installing Display Manager..."
	sudo pacman -S --needed sddm

	echo "Installing i3-gaps..."
	sudo pacman -S --needed i3-gaps

	echo "Installing polybar..."
	sudo yay -S polybar

	echo "Installing picom..."
	sudo yay -S picom-ibhagwan-git

	echo "Installing rofi..."
	sudo pacman -S rofi

	echo "Installing fonts..."
	sudo pacman -S ttf-fira-code

	echo "Installing i3lock-color"
	sudo yay -S i3lock-color

	echo "Installation done"
	echo "Copy files to their respective places? [Y/N] "
	read ans
	ans="`echo ${ans:0:1} | awk '{print tolower($0)}'`" 

	if [ "$ans" == "y" ]; then
		cd $HOME/dotfiles 
		echo "Setting up SDDM"
		sudo mkdir /etc/sddm.conf.d && sudo cp sddm/sddm.conf /etc/sddm.conf.d
		sudo cp -r sddm/sugar-candy /usr/share/sddm/themes
		
		echo "Setting up config folder"
		cp -n .config/ $HOME

		echo "Setting up shell"
		sudo yay -S oh-my-zsh-git
		cp .zshrc $HOME cp -r .oh-my-zsh $HOME

		echo "Setting up fonts"
		sudo cp .fonts/*.ttf /usr/share/fonts

		#echo "Install additional packages? [Y/N]"
		#read ans
		#ans="`echo ${ans:0:1} | awk '{print tolower($0)}'`" 
		
		#if [ "$ans" == "y" ]; then
		#	sudo pacman -S firefox 
		#else

		#fi

	else
		exit
	fi

else
	echo "Not supported or invalid distro"
	exit
fi


