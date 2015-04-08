# Adobe AIR vs Cocos2d-js

This implements some build schemes for Cocos2D-js and Adobe AIR.

## License

What do you think?  It's just a bunch of build files.  I don't care what you do with them.  Don't blame me if you can't use them right, or something blows up in your face.  If you hate me for it, consider that I'll be using them, too, so maybe that's its own punishment.

The Example bits and pieces of the Cocos example belong to the Cocos people, and their licensing, at least until I adapt my own, dumb 'Example' for that side of the build.

https://github.com/cocos2d/cocos2d-js/blob/develop/LICENSE

http://www.adobe.com/products/air/sdk-eula.html

## Setup

See the [Setup](https://github.com/pingnak/AIRvsCocos/wiki/Setup) wiki page.  

https://github.com/pingnak/AIRvsCocos/wiki/Setup

It's not actually as hard as the length of it makes it look.  Well, except the iOS key stuff on the Windows side, for AIR.

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

For iOS, Android, or Adobe AIR targets, Mac or Windows will work.  I was not able to get a recent version of AIR to work in Linux, for now.  Adobe dropped their Flex/AIR SDK support for Linux a few years ago, and Apache Flex only works with AIR 4 parts... and apparently a lot of tinkering.

For a Windows Native installer, you need to build from Windows.  

For an OS X Native installer, you need to build from OS X. 

