#!/bin/bash

# this script is run by the root user in the virtual machine

set -e
set -x

echo "Setting up repo for ROS."

sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"

### Install ROS : taken from http://wiki.ros.org/kinetic/Installation/Ubuntu
# Configure your Ubuntu repositories
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

sudo apt-get update
# Installation
echo "Installing ROS."
sudo apt-get -y install ros-kinetic-ros-base
sudo apt-get -y install python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools


# Initialize rosdep
## TODO : fix that. It should be run only once
sudo rosdep init || true
su - vagrant -c 'rosdep update'

# Installing mavros
echo "Installing Mavros."
sudo apt-get -y install ros-kinetic-mavros
wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh


echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

sudo chmod +x ./install_geographiclib_datasets.sh
sudo ./install_geographiclib_datasets.sh

rm install_geographiclib_datasets.sh

# Install lubuntu for GUI
## TODO : look for less dependencies solution
### desktop-file-utils dmz-cursor-theme fcitx fcitx-config-gtk2 fcitx-frontend-gtk2 fcitx-ui-classic gnome-system-tools gnome-time-admin gvfs-backends indicator-application-gtk2 libfm-modules light-locker light-locker-settings lightdm-gtk-greeter-settings lubuntu-coreg lubuntu-default-session lxappearance  lxappearance-obconf lxinput lxpanel-indicator-applet-plugin lxrandr lxsession-default-apps lxterminal lxtask network-manager-gnome ntp obconf pm-utils xdg-user-dirs vfs-fuse xdg-user-dirs-gtk x11-utils
#sudo apt-get install -y lubuntu-desktop
echo "Installing ArduPilot"
rm -rf ardupilot || true
git clone https://github.com/ArduPilot/ardupilot
cd ardupilot
git submodule update --init --recursive
export HOME=/home/vagrant
sudo -u vagrant Tools/environment_install/install-prereqs-ubuntu.sh -y
echo "export PATH=$PATH:$HOME/ardupilot/Tools/autotest" >> /home/vagrant/.bashrc
echo "export PATH=/usr/lib/ccache:$PATH" >> /home/vagrant/.bashrc
sudo chown -R vagrant:vagrant /home/vagrant/ardupilot/