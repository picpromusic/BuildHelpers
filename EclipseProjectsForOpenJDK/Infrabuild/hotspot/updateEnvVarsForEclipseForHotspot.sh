#!/bin/bash

#
# Copyright (c) 2010, 2012, Oracle and/or its affiliates. All rights reserved.
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
# Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
# or visit www.oracle.com if you need additional information or have any
# questions.
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

# Location of the sources folder under the Home directory
export SOURCE_CODE=$HOME/sources

export TL_FOREST_FOLDER=$SOURCE_CODE/jdk8_tl

########################
## Pre- hotspot build ##
########################

# Hotspot makefiles location for building Hotspot
export HOTSPOT_MAKEFILES_LOC=$TL_FOREST_FOLDER/common/makefiles

# Arguments passed to the hotspot make command
export HOTSPOT_MAKE_ARGS='JAVAC_MAX_WARNINGS\=true NEW_BUILD\=true LANG\=C ZIP_DEBUGINFO_FILES\=0'

#########################
## Post- hotspot build ##
#########################

# Name of the OpenJDK build release
# extract data from OpenJDK's build-infra environment variables
export OPENJDK_RELEASE_NAME=linux-x86_64-normal-server-release

# Name of the compiler sub-folder depending on the OS and CPU
# extract data from OpenJDK's build-infra environment variables
export OS_PLATFORM_COMPILER_FOLDER=linux_amd64_compiler2

# Location where the hotspot binary can be found after a successful build
export HOTSPOT_BINARY_LOC=$TL_FOREST_FOLDER/build/$OPENJDK_RELEASE_NAME/hotspot/$OS_PLATFORM_COMPILER_FOLDER/product

# Java CLI arguments passed by the launcher
# arguments that can be passed to gamma (see java or gamma usage help by running java --help or gamma --help for additional options)
export JAVA_CLI_ARGS=-verbose\:class

# Location of the test class passed to the hotspot launcher
# This location can be anywhere on the system - depends where the 'HelloWorld.class' file or any other test class has been placed
export TESTCLASS_LOC=$HOME

# Name of a test class passed to the hotspot launcher
export TESTCLASSNAME=HelloWorld

# Location of the Java JDK/JRE used by the run launcher
# use 
# whereis java 
#       or 
# sudo update-alternatives --configure java
# at the CLI to figure out the exact location for JAVA_HOME
#
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

