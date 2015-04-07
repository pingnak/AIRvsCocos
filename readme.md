# Adobe AIR vs Cocos2d

This implements some build schemes for common middleware, based on recent work
with Cocos2D-js and Adobe AIR, specifically.

I decided to share because this is handy stuff, and I wanted a quick way to
start into either kind of project.

* Share a convenient Apache Ant build script for AIR SDK, which builds all of
the supported targets, and deploys/tests/debugs them.

* Document every step, from set up, to submit. This should be useful as an
example, for migrating between these environments, and keeping your code safe
and portable. Also, because I have 'old people' memory.

* Make a 'hands off' project scripts for Cocos2d-js, to keep the source
code, art, etc. from being scattered among tens of thousands of intermediate
garbage files, and correct some nasty gotchas, present in version 3.3 and 3.5.

## License

What do you think?  It's just a bunch of build files.  I don't care what you do
with them.  Don't blame me if you can't use them right, or something blows up
in your face.

The Example bits and pieces of the Cocos example belong to them, and their 
licensing, at least until I adapt my own, dumb 'Example' for that side.

https://github.com/cocos2d/cocos2d-js/blob/develop/LICENSE

http://www.adobe.com/products/air/sdk-eula.html

## Setup

See the 'Setup' wiki page.  It's not actually as hard as the length of it makes it look.

https://github.com/pingnak/AIRvsCocos/wiki/Setup

## System Requirements

### General

Some latter day version of Windows, OS X, or Linux

Recent JAVA JDK, Ant, Python

### Cocos2d-js

http://www.cocos2d-x.org/wiki/Cocos2d-x

Windows build targets require Microsoft Visual Studio 2012 or later.

OS X and iOS build targets require Apple OS X 10.7+ and XCODE 5.1+ (from the App Store) 

### Adobe AIR SDK

http://www.adobe.com/products/air/tech-specs.html

For iOS, Android, or Adobe AIR targets, Mac or Windows will work.  I was not able
to get a recent version to work in Linux, for now.  Adobe dropped their Flex/AIR  
SDK support for Linux a couple of years ago, and Apache Flex only works with AIR
4... and a lot of tinkering.

For a Windows Native installer, you need to build from Windows.  

For an OS X Native installer, you need to build from OS X. 

