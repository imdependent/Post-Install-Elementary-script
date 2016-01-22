#!/bin/bash

#!!!Script must be run as , not root!!!

#chmod +x post-install.sh
#sh post-install.sh

# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Author: Korotkov K. <i.am.korotkov@gmail.com>
#
# A post installation script to customize elementary OS Freya (https://elementary.io) to my use.

#Clean-up System
apt-get autoremove -y
apt-get autoclean

#Remove some Switchboard Plug's

rm -rf /usr/lib/plugs/GnomeCC/gnomecc-wacom.plug

#Update your system

apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y


#################################
#      REMOVE SOME PACKAGES     #
#################################

apt-get purge gcalctool -y
apt-get purge midori-granite -y
apt-get purge elementary-scan -y
apt-get purge totem -y
apt-get purge maya-calendar -y
apt-get purge shotwell -y
apt-get purge update-manager -y
apt-get purge empathy -y
#apt-get purge software-center -y

#Install support rus-lang
apt-get install -y language-pack-en language-pack-ru
echo 'LANG="ru_RU.UTF-8"' > /etc/default/locale
locale-gen

#Install restricted extras
apt-get install ubuntu-restricted-extras  -y
apt-get install -f -y

#################################
#   ADD PACKAGES REPOSITORIES   #
#################################
add-apt-repository ppa:thefanclub/ubuntu-after-install  -y
apt-add-repository ppa:tomato-team/tomato-stable  -y
apt-add-repository ppa:justsomedood/justsomeelementary  -y
add-apt-repository ppa:git-core/ppa  -y
apt-add-repository ppa:l-admin-3/apps-daily  -y
apt-add-repository ppa:justsomedood/justsomeelementary  -y
apt-add-repository ppa:erasmo-marin/webby-browser  -y
add-apt-repository ppa:appgrid/stable  -y
add-apt-repository ppa:noobslab/apps -y
add-apt-repository ppa:wiznote-team -y
add-apt-repository "ppa:mpstark/elementary-tweaks-daily" -y
add-apt-repository ppa:vikoadi/ppa -y
add-apt-repository "ppa:webupd8team/unstable" -y
add-apt-repository "ppa:videolan/stable-daily" -y

#sudo add-apt-repository ppa:openshot.developers/ppa

add-apt-repository ppa:yunnxx/gnome3 -y
add-apt-repository ppa:jfi/psensor-unstable -y
add-apt-repository ppa:voldyman/markmywords -y

#apt-add-repository ppa:eviltwin1/feedreader-daily -y

add-apt-repository "ppa:elementary-os/os-patches" -y
apt-add-repository -y ppa:justsomedood/justsomeelementary -y
add-apt-repository ppa:nemh/systemback -y
add-apt-repository ppa:apparmor-upload/apparmor-2.8  -y
add-apt-repository ppa:transmissionbt/ppa  -y
add-apt-repository ppa:noobslab/themes -y
wget http://archive.ualinux.com/ubuntu/main/all/ualinux-repository.deb  -y
sudo dpkg -i /tmp/ualinux-repository.deb  -y
wget -O getdeb-repository_0.1-1_all.deb http://goo.gl/ScikR  -y
sudo dpkg -i getdeb-repository_0.1-1_all.deb  -y
apt-add-repository -y ppa:justsomedood/justsomeelementary  -y
apt-add-repository ppa:versable/elementary-update  -y
add-apt-repository -y ppa:linrunner/tlp  -y
add-apt-repository -y ppa:inaddy/lp1415880  -y
apt-add-repository ppa:justsomedood/justsomeelementary  -y
add-apt-repository -y ppa:webupd8team/sublime-text-3  -y
add-apt-repository -y ppa:numix/ppa  -y
curl -sL http://i-hate-farms.github.io/spores/key/deb.gpg.key | sudo apt-key add -
add-apt-repository "deb http://i-hate-farms.github.io/spores trusty main"  -y
add-apt-repository -y ppa:videolan/stable-daily  -y
apt-add-repository ppa:bablu-boy/nutty.0.1 -y
add-apt-repository ppa:upubuntu-com/flareget-amd64  -y
add-apt-repository ppa:noobslab/icons  -y
apt-add-repository ppa:plushuang-tw/uget-stable  -y
add-apt-repository ppa:fossfreedom/indicator-sysmonitor   -y
add-apt-repository ppa:noobslab/indicators  -y
apt-add-repository ppa:justsomedood/justsomeelementary  -y
add-apt-repository ppa:otto-kesselgulasch/gimp -y
add-apt-repository ppa:ubuntu-desktop/ubuntu-make
add-apt-repository ppa:paolorotolo/android-studio
add-apt-repository ppa:webupd8team/gthumb

#################################
#  UPDATE KERNEL TO LATEST LTS  #
#################################

#sudo apt-get install -y --install-recommends linux-generic-lts-vivid xserver-xorg-core-lts-vivid xserver-xorg-lts-vivid xserver-xorg-video-all-lts-vivid xserver-xorg-input-all-lts-vivid libwayland-egl1-mesa-lts-vivid xserver-xorg-input-synaptics-lts-vivid linux-signed-generic-lts-vivid

#################################
#       PACKAGES UPGRADE        #
#################################

sudo apt-get dist-upgrade -y

#################################
#       INSTALL PACKAGES        #
#################################

# Fix resume from suspend issues

sudo apt-get install -y bcmwl-kernel-source

# MS Fonts

# accept agreement

echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo apt-get install -y ttf-mscorefonts-installer  -y

# Archive formats support

sudo apt-get install -y unace rar unrar p7zip-rar p7zip zip unzip sharutils uudeview mpack arj cabextract file-roller arj lzip lunzip lame flac  -y

# Some utils packages

sudo apt-get install -y git gdebi menulibre

# Preload (preload in RAM most used softwares)

sudo apt-get install -y preload 

# TLP (power management)

sudo apt-get install -y tlp tlp-rdw smartmontools ethtool thermald

# copy config file

wget https://raw.githubusercontent.com/rcatajar/elementary-os-config/master/data/tlp

sudo mv tlp /etc/default/

﻿# enables intel-pstate

wget https://raw.githubusercontent.com/rcatajar/elementary-os-config/master/data/grub

sudo mv grub /etc/default/

sudo update-grub

# JAVA VM

sudo apt-get install -y openjdk-7-jdk

#################################
#            CLEANUP            #
#################################

sudo apt-get -y autoremove
sudo apt-get -y autoclean

#################################
#         SYSTEM TWEAKS         #
#################################

# swap less agressivly

sudo bash -c "echo 'vm.swappiness = 10' >> /etc/sysctl.conf"

# set terminator as the default terminal

sudo update-alternatives --set x-terminal-emulator /usr/bin/terminator

# Improve wifi performance
# Set the wireless regulatory domain to France
sudo iw reg set FR
# Disable  802.11N (fix random disconnections)
sudo bash -c "echo 'options iwlwifi 11n_disable=1' >>/etc/modprobe.d/iwlwifi.conf"
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#################################
#         INSTALL APPS          #
#################################

sudo apt-get install hardinfo

#Install gThumb

apt-get install gthumb

#Install Telegram

apt-get update -y
apt-get install telegram-desktop -y
apt-get install -f -y

#Install WizNote

apt-get update -y
apt-get install wiznote  -y
apt-get install -f -y

#Install Apparmor 2.8

sudo apt-get update && sudo apt-get dist-upgrade  -y

#Install the latest git Version

sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install git

#Install Java 8

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer  -y

#Install Elementary OS extras

sudo apt-get install elementary-desktop elementary-tweaks  -y
sudo apt-get install elementary-dark-theme elementary-plastico-theme elementary-whit-e-theme elementary-harvey-theme  -y
sudo apt-get install elementary-elfaenza-icons elementary-nitrux-icons  -y
sudo apt-get install elementary-plank-themes  -y
sudo apt-get install wingpanel-slim indicator-synapse  -y

#Install a Firewall Application

sudo apt-get install gufw  -y

#Install Corebird - Twitter client

apt-get update -y
apt-get install corebird  -y

#Install elementary+ icon set

apt-get install elementary-plus  -y
apt-get update

# sublime

sudo apt-get install -y sublime-text-installer

# Transmissions

sudo apt-get install -y transmission-gtk

# Numix Circle Icons

sudo apt-get install -y numix-icon-theme-circle

# Modify the icon themes so that it only change the apps icons and keep the default folders/ indicators

wget https://raw.githubusercontent.com/rcatajar/elementary-os-config/master/data/icon-theme-fix/index.theme
sudo mv index.theme /usr/share/icons/Numix-Circle

# elementary tweaks

sudo apt-get install -y elementary-tweaks

# Dropbox
# Use a custom script because the ubuntu version is outdated and the indicator doesn't work

#mkdir -p ~/.config/autostart/   # make sure the autostart directory is here, otherwise the script crash
#cd /tmp
#wget -O dropbox.zip https://github.com/nathandyer/elementary-dropbox-mods/archive/master.zip
#unzip dropbox.zip
#cd elementary-dropbox-mods-master/
#./dropbox-elementary.sh
#sudo ./dropbox-elementary.sh
#./dropbox-elementary.sh

# VirtualBox

#cd /tmp
#sudo apt-get install -y dkms libsdl1.2debian
#wget http://download.virtualbox.org/virtualbox/5.0.6/virtualbox-5.0_5.0.6-103037~Ubuntu~trusty_amd64.deb
#sudo dpkg -i virtualbox-5.0_5.0.6-103037~Ubuntu~trusty_amd64.deb

# Eye of Gnome

sudo apt-get install -y eog

#Install Tomato timer

apt-get update
apt-get install tomato

#Install Configurator - config editor

apt-get install configurator  -y

#Install Footnote - note keeping

#apt-get update
#apt-get install footnote

#Install Webby - web app browser

apt-get install webby-browser  -y

#Install AppGrid

#apt-get update -y
#apt-get install appgrid -y


#Install Google Chrome

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'   -y
sudo apt-get update   -y
sudo apt-get install google-chrome-stable  -y

#Install ScreenCloud

wget -q -O- http://download.opensuse.org/repositories/home:olav-st/xUbuntu_14.04/Release.key |  apt-key add -  -y
add-apt-repository 'deb http://download.opensuse.org/repositories/home:/olav-st/xUbuntu_14.04/ /'  -y
apt-get update -y
apt-get install screencloud  -y

#Install ClipGrab

apt-get update -y
apt-get install clipgrab -y

#Install Elementary-tweaks

apt-get update -y
apt-get install elementary-tweaks -y

#Install KDEconnect

apt-get install indicator-kdeconnect kdeconnect  -y

#Install Synaptic

apt-get install synaptic -y

#Install VLC

apt-get install vlc -y

# Install Videoeditor (Openshot)

#sudo apt-fast install openshot openshot-doc


apt-get install gimp

#Install Power Installer

add-apt-repository -y ppa:donadigo/power-installer -y
apt-get install -y power-installer

#Install Indicator USB

apt-get install indicator-usb -y

#Install Psensor

apt install lm-sensors hddtemp psensor -y

#Install MarkMyWords

#apt-get install mark-my-words -y

#Install 
#umake android
#kvm-ok
#apt-get install qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils

#Install Feedreader

apt-get install feedreader -y

#Install dkms

apt-get install dkms -y

#Install Agenda, Translator

apt-get install agenda-tasks translator

#Install SystemBack

apt-get install systemback -y

#Install Copyq

sudo apt-get update  -y
sudo apt-get install copyq  -y
 
#System Monitor Indicator  -y

sudo apt-get update
sudo apt-get install indicator-sysmonitor  -y

#Install uget

sudo apt-get update
sudo apt-get install uget aria2  -y

#Install Emerald Icon

sudo apt-get install emerald-icon-theme  -y

sudo apt-get install flareget  -y

sudo apt-get install nutty  -y

sudo apt-get install nasc foto indicator-terminal elementary-plus anoise   -y

#go-for-it

#sudo apt-add-repository ppa:birdie-team/stable && sudo apt-get update
#sudo apt-get install birdie

#Install Transmission

apt-get install transmission-cli transmission-common transmission-daemon  -y

sudo apt-get install evnc  -y

#Install Ubuntu-touch Theme

apt-get install ubuntu-touch-theme

#Install Arc Theme

sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_15.04/ /' >> /etc/apt/sources.list.d/arc-theme.list"
apt-get update -y
apt-get install arc-theme

#Install Ubuntu After Install
sudo apt-get install ubuntu-after-install

#Install FileZilla 
wget -O - oduso.com/eime.sh | bash

#Install LAMP + phpmyadmin

sudo apt-get install -y lamp-server^
sudo apt-get install -y phpmyadmin

apt-get install android-studio


#Install NodeJS
sudo add-apt-repository ppa:chris-lea/node.js -y
sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make nodejs 

sudo apt-get install ubuntu-after-install

npm install --save gulp-install 
#npm install -g ionic


#Install other

apt-get install gdebi -y
#apt-get install gedit -y
apt-get install laptop-mode-tools -y
apt-get install conky-std -y
apt-get install lm-sensors -y
apt-get install gpicview -y
apt-get install gnome-disk-utility -y
apt-get install gparted -y
apt-get install bleachbit -y
apt-get install preload

dpkg --configure -a
apt-get install -f -y

# reboot
