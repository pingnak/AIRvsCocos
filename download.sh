#!/bin/sh

# For windows users, well, sorry.  I'm not going to write a DOS/cmd batch for you. 


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
#set -o verbose	# Echo every command

echo Downloading Pieces


