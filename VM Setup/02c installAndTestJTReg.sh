#!bin/sh
set -eu

#
# 02c installAndTestJTReg.sh - downloads, installs jtreg and runs a test to check if it has been coreectly installed.
# The script is a product of the instructions from the Adopt OpenJDK wiki page.
#
# Copyright (c) 2012 Martijn Verburg <martijn.verburg@gmail.com>, Mani Sarkar <sadhak001@gmail.com>. All rights reserved.
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

echo "*********************************"
echo "Changing to openjdk folder"
echo "*********************************"

# Moving to openjdk folder
cd ~/jtreg;

echo "******************************************************"
echo "Download & extracting jtreg into the jtreg folder"
echo "******************************************************"
# Download jtreg in the folder
wget "http://www.java.net/download/openjdk/jtreg/promoted/4.1/b04/jtreg-4.1-bin-b04_14_mar_2012.zip"

# Unzip file
echo "*********************************"
echo "Extracting jtreg to folder"
echo "*********************************"
unzip jtreg-4.1-bin-b04_14_mar_2012.zip

# vi ~/.bashrc
#And append:
#
echo "*********************************"
echo "Appending env settings to .bashrc"
echo "*********************************"
echo "export JT_HOME=/home/openjdk/jtreg" >> ~/.bashrc
echo "export PRODUCT_HOME=/home/openjdk/sources/jdk8_tl/build/linux-amd64_backup/j2sdk-image"  >> ~/.bashrc

# Then source the new default env settings
echo "*********************************"
echo "source bashrc"
echo "*********************************"
 source ~/.bashrc ;

#Sanity check jtreg
#Execute the following
echo "*********************************"
echo "Sanity check of jtreg"
echo "*********************************"
 . ../jdk8-env.sh
 cd ~/sources/jdk8_tl/test ;
 make jdk_util &> test.log ;
