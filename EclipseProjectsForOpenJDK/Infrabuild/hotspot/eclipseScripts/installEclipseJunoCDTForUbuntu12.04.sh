#!/bin/bash

set -eu

#
# installEclipseJunoCDTForUbuntu12.04.sh - installs 32- or 64- bit Eclipse Juno CDT on a Ubuntu system
#
# Copyright (c) 2013, Mani Sarkar <sadhak001@gmail.com> All rights reserved.
# 
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
#
# This code is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 2 only, as
# published by the Free Software Foundation.  Oracle designates this
# particular file as subject to the "Classpath" exception as provided
# by Oracle in the LICENSE file that accompanied this code.
#
# This code is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# version 2 for more details (a copy is included in the LICENSE file that
# accompanied this code).
#
# You should have received a copy of the GNU General Public License version
# 2 along with this work; if not, write to the Free Software Foundation,
# Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
#

##################################################################################################################
# Installing Eclipse Juno under Ubuntu 12.04                                                                     #
#                                                                                                                #
# usage:                                                                                                         #
#                                                                                                                #
# $ bash installEclipseJunoCDTForUbuntu12.04.sh                                                                  #
#                                                                                                                #
#  automatically detects which system i.e. 32- or 64-bits and downloads and run the appropriate system           #
#  *** Currently only tested under Ubuntu 12.04 ***                                                              #
#                                                                                                                #
##################################################################################################################
# To do the rest of the optional steps i.e. create a icon in the Unity Dashboard, etc... please refer to the last#
# section of the blog at http://ksearch.wordpress.com/2012/10/26/how-do-i-install-eclipse-juno-in-ubuntu-12-04/  #
##################################################################################################################

# Default platform is 32 bits
PLATFORM="32"

# Go to the Downloads folder
echo "Navigating to the Downloads folder."
cd ~/Downloads
echo "Navigation to the Downloads successful."

# Find out whether you are running a 32- or 64-bits system using  
# file /bin/bash

# Get machine's platform from OS
MACHINE_HARDWARE_NAME=$(uname -m)

# If it contains _x64, its a 64-bit system.
if echo "$MACHINE_HARDWARE_NAME" | grep -q "_64"; then
   PLATFORM="64";
fi

echo "Platform: $PLATFORM-bits system detected."

if [ "$PLATFORM" == "32" ]
then
   echo "Downloading $PLATFORM-bits binary package of Eclipse Juno for Ubuntu 12.04."
   wget http://mirrors.ibiblio.org/eclipse/technology/epp/downloads/release/juno/SR2/eclipse-cpp-juno-SR2-linux-gtk.tar.gz
elif [ $PLATFORM == 64 ]
then
   echo "Downloading $PLATFORM-bits binary package of Eclipse Juno for Ubuntu 12.04."
   wget http://mirrors.ibiblio.org/eclipse/technology/epp/downloads/release/juno/SR2/eclipse-cpp-juno-SR2-linux-gtk-x86_64.tar.gz
fi
echo "Download finished."

# Untar the downloaded file
if [ "$PLATFORM" == "32" ]
then
   echo "Untar-ing the $PLATFORM-bits downloaded binary."
   tar -zxvf eclipse-cpp-juno-SR2-linux-gtk.tar.gz
elif [ "$PLATFORM" == "64" ]
then
   echo "Untar-ing the $PLATFORM-bits downloaded binary."
   tar -zxvf eclipse-cpp-juno-SR2-linux-gtk-x86_64.tar.gz
fi
echo "Untar-ing of binary successful."

# This results in a folder named "eclipse", which should be copied to /opt with 
echo "Moving the eclipse folder to /opt"
sudo mv "eclipse" /opt
echo "Move successful."

# Now add a link to the executable in /usr/bin to "/opt/eclipse/eclipse" for easier access.
echo "Creating symbolic link at /opt/eclipse/eclipse for /usr/bin/eclipse"
sudo ln -s "/opt/eclipse/eclipse" /usr/bin/eclipse
echo "Link creation was successful."
