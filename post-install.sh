#!/bin/bash

#!!!Script must be run as , not root!!!

# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Author: Korotkov K. <i.am.korotkov@gmail.com>
#
# A post installation script to customize elementary OS Freya (https://elementary.io) to my use.

#Clean-up System
apt-get purge gcalctool -y
apt-get purge midori-granite -y
apt-get purge scratch-text-editor -y
apt-get purge elementary-scan -y
apt-get purge totem -y
apt-get purge maya-calendar -y
apt-get purge shotwell -y
apt-get purge update-manager -y
apt-get purge empathy -y
#apt-get purge software-center -y

apt-get autoremove -y
apt-get autoclean

#Remove some Switchboard Plug's
rm -rf /usr/lib/plugs/GnomeCC/gnomecc-wacom.plug

#Update your system
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

#Clean-up System
sudo apt-get purge midori-granite
sudo apt-get purge noise
sudo apt-get purge software-center
sudo apt-get purge scratch-text-editor
sudo apt-get purge bluez
sudo apt-get purge modemmanager
sudo apt-get autoremove
sudo apt-get autoclean

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

# TLP, improved power management
sudo add-apt-repository -y ppa:linrunner/tlp

# Fix resume from suspend issues for some laptops (DELL XPS13, MPB)
# see https://bugs.launchpad.net/ubuntu/+source/bcmwl/+bug/1415880
sudo add-apt-repository -y ppa:inaddy/lp1415880

# Sublime text 3
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3

# Numix icons
sudo add-apt-repository -y ppa:numix/ppa

# Elementary tweaks
curl -sL http://i-hate-farms.github.io/spores/key/deb.gpg.key | sudo apt-key add -
sudo add-apt-repository "deb http://i-hate-farms.github.io/spores trusty main"

# VLC
sudo add-apt-repository -y ppa:videolan/stable-daily

#################################
#  UPDATE KERNEL TO LATEST LTS  #
#################################
sudo apt-get install -y --install-recommends linux-generic-lts-vivid xserver-xorg-core-lts-vivid xserver-xorg-lts-vivid xserver-xorg-video-all-lts-vivid xserver-xorg-input-all-lts-vivid libwayland-egl1-mesa-lts-vivid xserver-xorg-input-synaptics-lts-vivid linux-signed-generic-lts-vivid


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
sudo apt-get install -y ttf-mscorefonts-installer

# Archive formats support
sudo apt-get install -y unace rar unrar p7zip-rar p7zip zip unzip sharutils uudeview mpack arj cabextract file-roller arj lzip lunzip lame flac

# Some utils packages
sudo apt-get install -y git htop vim zsh linux-tools-common linux-tools-generic dconf-tools gdebi menulibre

# C and C++ dev
sudo apt-get install -y build-essential make cmake g++ clang llvm-dev cpp libqt4-dev libxtst-dev libx11-6 libgeis-dev libclang-dev freeglut3-dev libjpeg-dev libfreetype6-dev libxrandr-dev libglew-dev libsndfile1-dev libopenal-dev  libudev-dev libxcb-icccm4-dev libxcb-image0-dev libsfml-dev cppcheck

# python dev
sudo apt-get install -y python-dev python-pip libblas-dev liblapack-dev libatlas-base-dev gfortran ipython ipython-notebook python-matplotlib
# python libraries
sudo pip install django requests numpy scipy panda pep8 pyflakes virtualenv virtualenvwrapper cpplint

# JS dev
# node
sudo apt-get install -y nodejs npm
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install -g tern babel-eslint json eslint jshint coffee coffeelint coffee-script underscore backbone mongo-hacker
# meteor
curl https://install.meteor.com/ | sh

# LaTeX support
sudo apt-get install -y texlive-full latexmk

# Preload (preload in RAM most used softwares)
sudo apt-get install -y preload

# TLP (power management)
sudo apt-get install -y tlp tlp-rdw smartmontools ethtool thermald
# copy config file
wget https://raw.githubusercontent.com/rcatajar/elementary-os-config/master/data/tlp
sudo mv tlp /etc/default/
# enables intel-pstate
wget https://raw.githubusercontent.com/rcatajar/elementary-os-config/master/data/grub
sudo mv grub /etc/default/
sudo update-grub

# JAVA VM
sudo apt-get install -y openjdk-7-jdk

# terminator
sudo apt-get install -y terminator

# spotify
sudo apt-get install -y spotify-client
# fix the indicator style
wget --no-check-certificate https://raw.githubusercontent.com/rcatajar/fix-spotify-icon/master/quickstart.sh -O - | sh

# sublime
sudo apt-get install -y sublime-text-installer

# LibreOffice
sudo apt-get install -y libreoffice libreoffice-style-breeze libreoffice-l10n-fr

# VLC
sudo apt-get install -y vlc

# Transmissions
sudo apt-get install -y transmission-gtk

# Numix Circle Icons
sudo apt-get install -y numix-icon-theme-circle
# Modify the icon themes so that it only change the apps icons and keep the default folders/ indicators
wget https://raw.githubusercontent.com/rcatajar/elementary-os-config/master/data/icon-theme-fix/index.theme
sudo mv index.theme /usr/share/icons/Numix-Circle

# elementary tweaks
sudo apt-get install -y elementary-tweaks

# google chrome
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-beta_current_amd64.deb
sudo dpkg -i google-chrome-beta_current_amd64.deb
sudo apt-get install -y libappindicator1
sudo apt-get install -f -y

# Dropbox
# Use a custom script because the ubuntu version is outdated and the indicator doesn't work
mkdir -p ~/.config/autostart/   # make sure the autostart directory is here, otherwise the script crash
cd /tmp
wget -O dropbox.zip https://github.com/nathandyer/elementary-dropbox-mods/archive/master.zip
unzip dropbox.zip
cd elementary-dropbox-mods-master/
./dropbox-elementary.sh
sudo ./dropbox-elementary.sh
./dropbox-elementary.sh

# Gtk-theme-variant-switcher (allow to force dark themes for some apps)
cd /tmp
wget -O switcher.zip https://github.com/theblacklion/gtk-theme-variant-switcher/archive/master.zip
unzip switcher.zip
cd gtk-theme-variant-switcher-master
make install
# add to startup
wget https://github.com/rcatajar/elementary-os-config/raw/master/data/autostart/gtk-theme-variant-switcher.desktop
mv gtk-theme-variant-switcher.desktop ~/.config/autostart/

# VirtualBox
cd /tmp
sudo apt-get install -y dkms libsdl1.2debian
wget http://download.virtualbox.org/virtualbox/5.0.6/virtualbox-5.0_5.0.6-103037~Ubuntu~trusty_amd64.deb
sudo dpkg -i virtualbox-5.0_5.0.6-103037~Ubuntu~trusty_amd64.deb

# Eye of Gnome
sudo apt-get install -y eog


#################################
#      REMOVE SOME PACKAGES     #
#################################

# Remove some default elementary apps, the ubuntu software center and the "Report an error" annoying popup
sudo apt-get remove -y midori-granite noise scratch-text-editor software-center software-center-aptdaemon-plugins audience pantheon-terminal geary apport apport-gtk apport-hooks-elementary pantheon-photos pantheon-photos-common


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


#Install Apparmor 2.8
sudo add-apt-repository ppa:apparmor-upload/apparmor-2.8
sudo apt-get update && sudo apt-get dist-upgrade

#Install the latest git Version
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install git

#Install Java 7
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer

#Install Elementary OS extras
sudo apt-add-repository ppa:versable/elementary-update
sudo apt-get update

sudo apt-get install elementary-desktop elementary-tweaks
sudo apt-get install elementary-dark-theme elementary-plastico-theme elementary-whit-e-theme elementary-harvey-theme
sudo apt-get install elementary-elfaenza-icons elementary-nitrux-icons
sudo apt-get install elementary-plank-themes
sudo apt-get install wingpanel-slim indicator-synapse

#Install a Firewall Application
sudo apt-get install gufw

#Install gedit (Text Editor)
sudo apt-get install gedit gedit-plugins

#Install Corebird - Twitter client
apt-add-repository ppa:justsomedood/justsomeelementary
apt-get update -y
apt-get install corebird

#Install Telegram
add-apt-repository ppa:noobslab/apps -y
apt-get update -y
apt-get install telegram-desktop -y
apt-get install -f -y

#Install WizNote
add-apt-repository ppa:wiznote-team -y
apt-get update -y
apt-get install wiznote
apt-get install -f -y

#Install elementary+ icon set
apt-add-repository ppa:justsomedood/justsomeelementary
apt-get update
apt-get install elementary-plus

#Install Tomato timer
apt-add-repository ppa:tomato-team/tomato-stable
apt-get update
apt-get install tomato

#Install Configurator - config editor
apt-add-repository ppa:l-admin-3/apps-daily
apt-get update
apt-get install configurator

#Install Footnote - note keeping
apt-add-repository ppa:justsomedood/justsomeelementary
apt-get update
apt-get install footnote

#Install Webby - web app browser
apt-add-repository ppa:erasmo-marin/webby-browser
apt-get update
apt-get install webby-browser

#Install AppGrid
add-apt-repository ppa:appgrid/stable  -y
 apt-get update -y
 apt-get install appgrid -y

apt-get install -f -y

#Install Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

#Install ScreenCloud
wget -q -O- http://download.opensuse.org/repositories/home:olav-st/xUbuntu_14.04/Release.key |  apt-key add -  -y
add-apt-repository 'deb http://download.opensuse.org/repositories/home:/olav-st/xUbuntu_14.04/ /'  -y
apt-get update -y
apt-get install screencloud

apt-get install -f -y

#Install ClipGrab
add-apt-repository ppa:noobslab/apps -y
 apt-get update -y
 apt-get install clipgrab -y

apt-get install -f -y

#Install Elementary-tweaks
add-apt-repository "ppa:mpstark/elementary-tweaks-daily" -y
apt-get update -y
apt-get install elementary-tweaks -y

apt-get install -f -y

#Install KDEconnect
 add-apt-repository ppa:vikoadi/ppa -y
 apt-get update -y
 apt-get install indicator-kdeconnect kdeconnect  -y

apt-get install -f -y

#Install Synaptic
add-apt-repository "ppa:webupd8team/unstable" -y
apt-get update -y
apt-get install synaptic -y

apt-get install -f -y

#Install VLC
add-apt-repository "ppa:videolan/stable-daily" -y
apt-get update -y
apt-get install vlc -y

apt-get install -f -y

# Install Videoeditor (Openshot)
sudo add-apt-repository ppa:openshot.developers/ppa
sudo apt-fast install openshot openshot-doc

#Install Power Installer
#Installation on elementary OS Freya:
add-apt-repository -y ppa:donadigo/power-installer -y
apt-get update -y
apt-get install -y power-installer

#Installation on other Ubuntu-based distributions (14.04 – 15.04):
#add-apt-repository -y ppa:donadigo/donadigo &&  apt-get update &&  apt-get install -y power-installer

apt-get install -f -y

#Install Indicator USB
add-apt-repository ppa:yunnxx/gnome3 -y
apt-get update -y
apt-get install indicator-usb -y

apt-get install -f -y

#Install Psensor
add-apt-repository ppa:jfi/psensor-unstable -y
apt-get update -y
apt install lm-sensors hddtemp psensor -y

apt-get install -f -y

#Install MarkMyWords
add-apt-repository ppa:voldyman/markmywords -y
apt-get update -y
apt-get install mark-my-words -y

apt-get install -f -y

#Install Feedreader
apt-add-repository ppa:eviltwin1/feedreader-daily -y
apt-get update -y
apt-get install feedreader -y

apt-get install -f -y

#Install dkms
add-apt-repository "ppa:elementary-os/os-patches" -y
apt-get update -y
apt-get install dkms -y

apt-get install -f -y

#Install Agenda, Translator, Taxi
apt-add-repository -y ppa:justsomedood/justsomeelementary -y
apt-get update -y
apt-get install agenda-tasks translator taxi
apt-get install -f -y

#Install SystemBack
add-apt-repository ppa:nemh/systemback -y
apt-get update -y
apt-get install systemback -y
apt-get install -f -y

#Install Transmission
add-apt-repository ppa:transmissionbt/ppa
apt-get update
apt-get install transmission-cli transmission-common transmission-daemon
apt-get install -f -y

#Install Ubuntu-touch Theme
add-apt-repository ppa:noobslab/themes -y
apt-get update -y
apt-get install ubuntu-touch-theme

#Install Arc Theme
sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_15.04/ /' >> /etc/apt/sources.list.d/arc-theme.list"
apt-get update -y
apt-get install arc-theme

#Install other
apt-get install gdebi -y
apt-get install gedit -y
apt-get install laptop-mode-tools -y
apt-get install conky-std -y
apt-get install lm-sensors -y
apt-get install gpicview -y
apt-get install gnome-system-monitor -y
apt-get install gnome-disk-utility -y
apt-get install gparted -y
apt-get install g++-mingw-w64-i686 -y
apt-get install git -y
apt-get install bleachbit -y
apt-get install preload

apt-get install -f -y

# reboot
