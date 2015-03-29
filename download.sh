#!/bin/sh

# For windows users, well, sorry.  I'm not going to write a DOS/cmd batch for you, right now. 


# COCOS 2D Requirements
# http://www.cocos2d-x.org/download

# Adobe AIR
# https://get.adobe.com/air/
# http://www.adobe.com/devnet/air/air-sdk-download.html
# http://ant.apache.org/
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

# Set BASH options 
set -o errexit	# Stop running the script if an error occurs
set -o nounset	# Stop running the script if a variable isn't set
set -o verbose	# Echo every command

echo Downloading Pieces

downloads=./dependencies
wget_flags="--continue --directory-prefix=$downloads"

# Get Apache ANT
wget $wget_flags https://www.apache.org/dist/ant/binaries/apache-ant-1.9.4-bin.zip

# Get Cocos2D-js
wget $wget_flags http://www.cocos2d-x.org/filedown/cocos2d-js-v3.3.zip

pushd $downloads
unzip -u -d ant "apache-ant-1.9.4-bin.zip"
unzip -u -d cocos2d-js "cocos2d-js-v3.3.zip"
popd

if [ `uname` = Darwin ] ; then
    # Adobe AIR SDK
    wget $wget_flags http://airdownload.adobe.com/air/mac/download/latest/AIRSDK_Compiler.tbz2
    # OpenFLEX
#   wget $wget_flags http://www.apache.org/dyn/closer.cgi?path=/flex/installer/3.1/binaries/apache-flex-sdk-installer-3.1.0-bin.dmg
    # Get various OS X Android parts
    wget $wget_flags http://dl.google.com/android/android-sdk_r24.1.2-macosx.zip
    wget $wget_flags http://dl.google.com/android/ndk/android-ndk-r10d-darwin-x86_64.bin

pushd $downloads
    tar jvxfk -C AIR "AIRSDK_Compiler.tbz2"
    unzip -u -d android-sdk "android-sdk_r24.1.2-macosx.zip"

    # Evil, self-extracting installer.    
    chmod +x "android-ndk-r10d-darwin-x86_64.bin"
    ./android-ndk-r10d-darwin-x86_64.bin
popd
        
else
    # If not running in OS X, assume Linux
    wget $wget_flags http://dl.google.com/android/ndk/android-ndk-r10d-linux-x86_64.bin
    wget $wget_flags http://dl.google.com/android/android-sdk_r24.1.2-linux.tgz
    # OpenFLEX
    wget $wget_flags http://www.apache.org/dyn/closer.cgi?path=/flex/installer/3.1/apache-flex-sdk-installer-3.1.0-src.tar.gz

pushd $downloads
    tar xvzfk -C flex "apache-flex-sdk-installer-3.1.0-src.tar.gz"
    tar xvzfk -C 'android-sdk' "android-sdk_r24.1.2-linux.tgz"

    # Evil, self-extracting installer.    
    chmod +x "android-ndk-r10d-linux-x86_64.bin"
    ./android-ndk-r10d-linux-x86_64.bin
popd
    
fi

