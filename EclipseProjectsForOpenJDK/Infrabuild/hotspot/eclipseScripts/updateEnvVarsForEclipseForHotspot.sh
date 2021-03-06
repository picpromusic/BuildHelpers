#!/bin/bash

set -eu

#
# updateEnvVarsForEclipseForHotspot.sh - updates the environment variables for reuse in the Hotspot Eclipse project files
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
# Update Environment variables to help build Hotspot                                                             #
##################################################################################################################
#                                                                                                                #
# usage:                                                                                                         #
#                                                                                                                #
# $ source updateEnvVarsForEclipseForHotspot.sh                                                                  #
#                                                                                                                #
# only then will the export commands in this file take effect in the OS environment                              #
#                                                                                                                #
# In order to see these OS environment variables in Eclipse, do the below at the CLI:                            #
#                                                                                                                #
# $ eclipse -data <OPENJDK_WORKSPACE_NAME> &                                                                     #
#                                                                                                                #
# These variable below will be visible in the list of variable in the Build Configuration tabs & sub-tabs using  #
# the ${<OS VARIABLE NAME>} notation and will be accessible in the Run/Debug Configuration tabs and sub-tabs via # 
# the 'env_var' notation i.e. ${env_var:<OS VARIABLE NAME>}                                                      #
#                                                                                                                #
##################################################################################################################

########################
## Prepare for build  ##
########################

### Location of the Home folder is stored in the $HOME environment variable ###

echo "************************************************************************************************************"
#
# Location of the sources folder under the Home directory
#
export SOURCE_CODE=$HOME/sources
echo "SOURCE_CODE has been set to '$SOURCE_CODE'"

echo "************************************************************************************************************"
export TL_FOREST_FOLDER=$SOURCE_CODE/jdk8_tl
echo "TL_FOREST_FOLDER has been set to '$TL_FOREST_FOLDER'"

########################
## Pre- hotspot build ##
########################

#
# Hotspot makefiles location for building Hotspot
#
echo "************************************************************************************************************"
export HOTSPOT_MAKEFILES_LOC=$TL_FOREST_FOLDER/common/makefiles
echo "HOTSPOT_MAKEFILES_LOC has been set to '$HOTSPOT_MAKEFILES_LOC'"

#
# Arguments passed to the hotspot make command
#
echo "************************************************************************************************************"
export HOTSPOT_MAKE_ARGS="JAVAC_MAX_WARNINGS\=true NEW_BUILD\=true LANG\=C ZIP_DEBUGINFO_FILES\=0"
echo "HOTSPOT_MAKE_ARGS has been set to '$HOTSPOT_MAKE_ARGS'"

#########################
## Post- hotspot build ##
#########################

#
# Location where the latest hotspot binary can be found after a successful build
#
export HOTSPOT_BINARY_LOC=$(find $TL_FOREST_FOLDER/build/ -name 'gamma')
echo "************************************************************************************************************"
if [ "$HOTSPOT_BINARY_LOC" == "" ]; then   
   echo "HOTSPOT_BINARY_LOC is not defined. Hotspot might have not been built via CLI or Eclipse. The Run/Debug launch in Eclipse will fail." 
   echo "You have three options, followed by re-running this script:" 
   echo "a) Build Hotspot via the command-line interface"
   echo "b) Build Hotspot in Eclipse, shutdown Eclipse."
   echo "c) Change the value to HOTSPOT_BINARY_LOC manually if the script or Eclipse is failing."
else
   echo "HOTSPOT_BINARY_LOC has been set to '$HOTSPOT_BINARY_LOC'"
fi

#
# Java CLI arguments passed by the launcher
# arguments that can be passed to gamma (see java or gamma usage help by running java --help or gamma --help for additional options)
#
export JAVA_CLI_ARGS=-verbose\:class
echo "************************************************************************************************************"
echo "JAVA_CLI_ARGS has been set to '$JAVA_CLI_ARGS'"

#
# Argument containing the location and name of the test class or jar passed to the hotspot launcher.
# This location can be anywhere on the system - depends where the 'HelloWorld.class' file or any other test class has been placed.
#
#
# Uncomment this line when you have a sample class or jar to pass to gamma
# export DEMOCLASS_OR_JAR_ARG="-cp $HOME HelloWorld"

# This will invoke gamma to display the usage screen
export DEMOCLASS_OR_JAR_ARG=""
echo "************************************************************************************************************"
echo "DEMOCLASS_OR_JAR_ARG has been set to '$DEMOCLASS_OR_JAR_ARG'"

#
# Location of the Java JDK/JRE used by the run launcher
# use one of the two:
#
# whereis java 
#       or 
# sudo update-alternatives --configure java
# at the CLI to find out the exact location to set for JAVA_HOME
#
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
echo "************************************************************************************************************"
if [ "$JAVA_HOME" == "" ]; then
   echo "JAVA_HOME is not defined, installed JDK/JRE folder cannot be found, please change script manually. The Run/Debug launch in Eclipse will fail."
else
   echo "JAVA_HOME has been set to '$JAVA_HOME'"
fi
echo "************************************************************************************************************"
