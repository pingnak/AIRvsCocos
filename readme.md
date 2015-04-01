# Adobe AIR vs Cocos2d

This implements some build schemes for common middleware, based on recent work 
with Cocos2D-js and Adobe AIR, specifically.

I decided to share because this is handy stuff, and I wanted a quick way to start into either kind of project.

* I will make 'hands off' project scripts for Cocos2d-js, to keep the source code, art, etc. from being scattered among tens of thousands of intermediate garbage files, and corrects some nasty gotchas, present in version 3.3.

* Share a convenient Apache Ant build script for AIR SDK, which builds all of the supported targets, and deploys/tests/debugs them.

* Document every step, from set up, to submit. This should be useful as an example, for migrating between these environments, and keeping your code safe and portable.  Also, because I have old-people memory.  

## Setup

Once you have a local copy through git, run the 'setup' script.  This will download 
all of the parts it can, set up the environment, and launch the 'android' tool, 
to pick out other bits of the Android SDK, for the Cocos2D side of things.

For iOS things, the AIR SDK should work without any external dependencies.  You
still have to jump through the iOS Developer hoops.  For Cocos2D, you'll need to 
install XCODE from the OS X App Store, then (like Android) pick through the other
bits you need.

