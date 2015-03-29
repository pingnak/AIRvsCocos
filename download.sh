#!/bin/sh

#
# Implied requirement: Java build environment (JDK)
#
# Apache Ant - build scripting
# http://ant.apache.org/
#
# COCOS 2D Requirements
# http://www.cocos2d-x.org/download
#
# Android requirements for Cocos2D
# https://developer.android.com/sdk/installing/index.html
# https://developer.android.com/tools/sdk/ndk/index.html
#
# iOS requirements for Cocos2D
# OS X, running on a Mac
# XCODE, from the 'App Store'
# All of the relevent XCODE bits, downloaded from XCODE
#
# Adobe AIR
# https://get.adobe.com/air/
# http://www.adobe.com/devnet/air/air-sdk-download.html
# 
#
# Fix AIR SDK fdb, so it 'works'.  Once you have it in your path, type 'fdb'.  It complains about wanting a 32 bit java runtime.  
# Edit the 'fdb' script in the bin folder.  Replace the 'java' invocation with a hard-coded path to java
#java $VMARGS $D32 $SETUP_SH_VMARGS -Dapplication.home="$FALCON_HOME" -jar "${FALCON_HOME}/lib/legacy/fdb.jar" "$@"
#/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Commands/java $VMARGS -D32 $SETUP_SH_VMARGS -Dapplication.home="$FALCON_HOME" -jar "${FALCON_HOME}/lib/legacy/fdb.jar" "$@"
#
# Where to get the JRE 6 package that works, for later OS X versions.  
# https://support.apple.com/kb/DL1572?locale=en_US
#

#
# For windows users, this will be a separate 'download.bat' file.
# One giant pile of testing, at a time...
#
# Windows 7
# Visual Studio 2012+
# Python 2.7
#


# Set BASH options 
set -o errexit	# Stop running the script if an error occurs
set -o nounset	# Stop running the script if a variable isn't set
set -o verbose	# Echo every command

echo Downloading Pieces

downloads=./depends
wget_flags="--continue --directory-prefix=$downloads"

#
# Get Apache ANT
#
wget $wget_flags https://www.apache.org/dist/ant/binaries/apache-ant-1.9.4-bin.zip
unzip -d $downloads "$downloads/apache-ant-1.9.4-bin.zip"

#
# Get Adobe AIR SDK
#

# Get the rest of the AIR SDK requirements...
if [ `uname` = Darwin ] ; then
    # Adobe AIR SDK
    wget $wget_flags http://airdownload.adobe.com/air/mac/download/latest/AIRSDK_Compiler.tbz2
    mkdir -p "$downloads/AIRSDK"
    tar jxfk "$downloads/AIRSDK_Compiler.tbz2" -C "$downloads/AIRSDK"
else
    # OpenFLEX
    wget $wget_flags http://www.apache.org/dyn/closer.cgi?path=/flex/installer/3.1/apache-flex-sdk-installer-3.1.0-src.tar.gz
    mkdir -p "$downloads/FlexSDK"
    tar xzf "$downloads/apache-flex-sdk-installer-3.1.0-src.tar.gz" -C "$downloads/FlexSDK"
fi

#
# Get Cocos2D and other bits and pieces
#

# Get Cocos2D-js
wget $wget_flags http://www.cocos2d-x.org/filedown/cocos2d-js-v3.3.zip
unzip -d $downloads "$downloads/cocos2d-js-v3.3.zip"

# Get Cocos2D-x
#wget $wget_flags http://www.cocos2d-x.org/filedown/cocos2d-x-3.4.zip
#unzip -d $downloads "$downloads/cocos2d-x-3.4.zip"

if [ `uname` = Darwin ] ; then
    # Get various OS X Android parts
    wget $wget_flags http://dl.google.com/android/android-sdk_r24.1.2-macosx.zip
    unzip -d $downloads "$downloads/android-sdk_r24.1.2-macosx.zip"

    # Evil, self-extracting installer for Android NDK
    wget $wget_flags http://dl.google.com/android/ndk/android-ndk-r10d-darwin-x86_64.bin
    
    pushd $downloads
    chmod +x "android-ndk-r10d-darwin-x86_64.bin"
    ./android-ndk-r10d-darwin-x86_64.bin
    popd

else
    # If not running in OS X, assume Linux

    wget $wget_flags http://dl.google.com/android/android-sdk_r24.1.2-linux.tgz
    tar xzfk "$downloads/android-sdk_r24.1.2-linux.tgz" -C "$downloads"

    # Evil, self-extracting installer for Android NDK
    wget $wget_flags http://dl.google.com/android/ndk/android-ndk-r10d-linux-x86_64.bin
    pushd $downloads
    chmod +x "android-ndk-r10d-linux-x86_64.bin"
    ./android-ndk-r10d-linux-x86_64.bin
    popd
    
fi

