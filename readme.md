# Adobe AIR vs Cocos2d-js

This implements some build schemes for Cocos2D-js and Adobe AIR.  

I attempt to provide a way to reconstruct a project with the tools originally used to create it, and make it trivial to set up a build environment, for others to play along.

[The Wiki Page](https://github.com/pingnak/AIRvsCocos/wiki) goes into more depth.

## Setup

See the [Setup](https://github.com/pingnak/AIRvsCocos/wiki/Setup) wiki page.  

https://github.com/pingnak/AIRvsCocos/wiki/Setup

It's not actually as hard as the length of it makes it look.  Well, except the iOS key stuff on the Windows side, for AIR.

## System Requirements

### General

Some latter day version of Windows, OS X, or Linux

Recent JAVA JDK, Ant, Python

### Cocos2d-js

Windows build targets require Microsoft Visual Studio 2012 or later.

OS X and iOS build targets require Apple OS X 10.7+ and XCODE 5.1+ (from the App Store) 

Linux target requires more work, in a new virtual machine.  I could build Android from Linux, but not Linux from my version.

http://www.cocos2d-x.org/wiki/Cocos2d-x

https://github.com/cocos2d/cocos2d-js/blob/develop/LICENSE

### Adobe AIR SDK

For iOS, Android, or Adobe AIR targets, Mac or Windows will work.

For a Windows Native installer, you need to build from Windows.  

For an OS X Native installer, you need to build from OS X. 

In Flash its self, there are discrpancies in how Windows vs. Mac versions render fonts into the output, so at least be aware of that.

http://www.adobe.com/products/air/tech-specs.html

http://www.adobe.com/products/air/sdk-eula.html

## License

It's just a bunch of build scripts.  I don't care what you do with them.  Don't blame me if you can't use them right, or something blows up in your face.  If you hate me for it, consider that I'll be using them, too, so maybe that's its own punishment.

The Example bits and pieces of the Cocos example belong to the Cocos people, and their licensing, at least until I adapt my own, dumb 'Example' for that side of the build.
