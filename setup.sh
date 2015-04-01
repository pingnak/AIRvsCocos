#!/bin/sh

#
# Download SDK bits and pieces, required to perform the build.
# Yes, this will probably code-rot, based on various web site links.
#

#
# Implied requirement: Java runtime environment (JDK/JRE)
#
# Adobe AIR
# https://get.adobe.com/air/
# http://www.adobe.com/devnet/air/air-sdk-download.html
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
# Windows 7+
# Visual Studio 2012+
# https://www.visualstudio.com/
# Python 2.7
# https://www.python.org/download/releases/2.7.6/
#

# Some app store links...
# https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa
# https://play.google.com/apps/publish
# https://developer.amazon.com/
# https://appdev.microsoft.com/StorePortals/en-us/account/signup/start

# Set BASH options 
set -o errexit	# Stop running the script if an error occurs
set -o nounset	# Stop running the script if a variable isn't set
#set -o verbose	# Echo every command

echo Downloading Pieces

downloads=depends
wget_flags="--continue --directory-prefix=$downloads"

#
# Get Apache ANT
#
if [ ! -d "$downloads/apache-ant" ]
then
    wget $wget_flags https://www.apache.org/dist/ant/binaries/apache-ant-1.9.4-bin.zip
    unzip -o -d $downloads "$downloads/apache-ant-1.9.4-bin.zip"
    mv -f "$downloads/apache-ant-1.9.4" "$downloads/apache-ant"
fi

#
# Get Adobe AIR SDK
#
if [ `uname` = Darwin ]
then
    # Adobe AIR SDK
    if [ ! -d "$downloads/AIRSDK" ] ; then
        wget $wget_flags http://airdownload.adobe.com/air/mac/download/latest/AIRSDK_Compiler.tbz2
        echo Extracting AIR SDK...
        mkdir -p "$downloads/AIRSDK"
        tar jxf "$downloads/AIRSDK_Compiler.tbz2" -C "$downloads/AIRSDK"
    fi
else
    # OpenFLEX
    if [ ! -d "$downloads/FlexSDK" ] ; then
        wget $wget_flags http://www.apache.org/dyn/closer.cgi?path=/flex/installer/3.1/apache-flex-sdk-installer-3.1.0-src.tar.gz
        echo Extracting Flex SDK...
        mkdir -p "$downloads/AIRSDK"
        tar zxf "$downloads/apache-flex-sdk-installer-3.1.0-src.tar.gz" -C "$downloads/AIRSDK"
    fi
fi

#
# Get Cocos2D and other bits and pieces
#

# Get Cocos2D-js
if [ ! -d "$downloads/cocos2d-js" ]
then
    wget $wget_flags http://www.cocos2d-x.org/filedown/cocos2d-js-v3.3.zip
    echo Extracting Cocos2d...
    unzip -o -d $downloads "$downloads/cocos2d-js-v3.3.zip"
    mv -f "$downloads/cocos2d-js-v3.3" "$downloads/cocos2d-js"
fi

# Get the Android parts...
if [ `uname` = Darwin ]
then
    if [ ! -d "$downloads/android-sdk" ]
    then
        # Get various OS X Android parts
        wget $wget_flags http://dl.google.com/android/android-sdk_r24.1.2-macosx.zip

        echo Extracting Android SDK...
        unzip -o -d $downloads "$downloads/android-sdk_r24.1.2-macosx.zip"
        mv -f "$downloads/android-sdk-macosx" "$downloads/android-sdk"
    fi

    if [ ! -d "$downloads/android-ndk" ]
    then
        # Evil, self-extracting installer for Android NDK
        wget $wget_flags http://dl.google.com/android/ndk/android-ndk-r10d-darwin-x86_64.bin
        
        echo Extracting Android NDK...
        pushd $downloads
        chmod +x "android-ndk-r10d-darwin-x86_64.bin"
        ./android-ndk-r10d-darwin-x86_64.bin
        popd
        
        mv -f "$downloads/android-ndk-r10d" "$downloads/android-ndk"
    fi

else
    # If not running in OS X, assume Linux

    if [ ! -d "$downloads/android-sdk" ]
    then
        wget $wget_flags http://dl.google.com/android/android-sdk_r24.1.2-linux.tgz
    
        echo Extracting Android SDK...
        tar xzf "$downloads/android-sdk_r24.1.2-linux.tgz" -C "$downloads"
        mv -f "$downloads/android-sdk-linux" "$downloads/android-sdk"
    fi

    if [ ! -d "$downloads/android-ndk" ]
    then
        # Evil, self-extracting installer for Android NDK
        wget $wget_flags http://dl.google.com/android/ndk/android-ndk-r10d-linux-x86_64.bin
    
        echo Extracting Android NDK...
        pushd $downloads
        chmod +x "android-ndk-r10d-linux-x86_64.bin"
        ./android-ndk-r10d-linux-x86_64.bin
        popd
        
        mv -f "$downloads/android-ndk-r10d-linux-x86_64" "$downloads/android-ndk"
    fi
fi

echo Generating Apache Ant and Adobe AIR properties

# Where the dependencies folder goes
rootdepends=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/$downloads

# Where various APIs live
whereantis=$rootdepends/apache-ant
whereairis=$rootdepends/AIRSDK
whereflexis=$rootdepends/FlexSDK
wherecocosis=$rootdepends/cocos2d-js
whereandroidsdkis=$rootdepends/android-sdk
whereandroidndkis=$rootdepends/android-ndk

bash_profile=$(dirname ~/.bash_profile)/.bash_profile
echo "Installing paths to $bash_profile"

if grep -q ANT_ROOT $bash_profile; then
    echo ANT already installed.
else
    echo "export ANT_ROOT=$whereantis/bin" >> $bash_profile
    echo 'export PATH=$ANT_ROOT/bin:$PATH' >> $bash_profile
fi

if grep -q AIR_ROOT $bash_profile; then
    echo AIR already installed.
else
    echo "export AIR_ROOT=$whereairis" >> $bash_profile
    echo 'export PATH=$AIR_ROOT/bin:$PATH' >> $bash_profile
fi

if grep -q COCOS_CONSOLE_ROOT $bash_profile; then
    echo COCOS already installed.
else
    echo "export COCOS_CONSOLE_ROOT=$wherecocosis/tools/cocos2d-console/bin" >> $bash_profile
    echo 'export PATH=$COCOS_CONSOLE_ROOT:$PATH' >> $bash_profile
    
    # Add environment variable COCOS_FRAMEWORKS for cocos2d-x
    echo "export COCOS_FRAMEWORKS=$wherecocosis/frameworks" >> $bash_profile
    echo 'export PATH=$COCOS_FRAMEWORKS:$PATH' >> $bash_profile
fi

if grep -q ANDROID_SDK_ROOT $bash_profile; then
    echo ANDROID SDK already installed.
else
    echo "export ANDROID_SDK_ROOT=$whereandroidsdkis" >> $bash_profile
fi
if grep -q NDK_ROOT $bash_profile; then
    echo ANDROID NDK already installed.
else 
    echo "export NDK_ROOT=$whereandroidndkis" >> $bash_profile
fi

# Invoke android SDK, to download more stuff
if pgrep -q -f com.android.sdkmanager.Main ; then
    echo $whereandroidsdkis/tools/android already running...
else
    $whereandroidsdkis/tools/android &
fi

echo
echo Type this to import variables into current session...
echo source $bash_profile
echo


