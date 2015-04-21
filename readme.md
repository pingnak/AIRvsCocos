# Adobe AIR vs Cocos2d-js

This implements build schemes for Cocos2D-js and Adobe AIR.  The air side of things is pretty trivial.  It's mainly there for reference and comparison.

For Cocos, I attempt to provide a way to reconstruct a project with the tools originally used to create it, and make it trivial to set up a build environment, for others to play along.

There were several problems in Cocos2d-js that I wanted to address...

* The contents of the src folder would disappear... *with your source code*.  It apparently *moves* the contents from project to sub-project.  If there's a problem, or you interrupt it, or attempt two builds at once in different shells, expect a meltdown.

* The Cocos project has absolute paths in it, once you've built things.  It can't be moved trivially to another computer, and built.  Picking and choosing what should be added to version control is a problem.

* When you make a new iOS project, it sticks ' iOS.ipa' on the end.  The app store rejects that, and it's difficult to fix, once the project gets built around it.  It's a trivial one-file, regex fix, but it's still there in Cocos2d.

* When it melts down, a Cocos project is difficult to fix.  I ended up re-creating the project again and again, and copying source files by hand, to get different platforms working.

* Once you've built a few platforms, there are tens of thousands of files and gigabytes of intermediate 'junk' in the Cocos project.

* Setting it up is an ordeal.  It has a lot of *specific* build dependencies, and many 'wrong ways' to do set up.  Even talking other programmers through setting it up for the first time is a chore.

* Adding/changing things required endless, direct fiddling around in project.json and resource.js.  

* The two different debuggers in their IDE *don't work* with the Javascript source code.  When there's a problem with something other than the web build, you're back to trace and shotgun debugging.

How I addressed things...

* I wrote an ant build script to download and configure the build requirements in a project's own 'depends' folder.  This means you can work on different versions of cocos/sdks, with different game projects, at the same time, without re-configuring your computer.  It's a lot easier to talk someone through setting up.

* I wrapped an ant build project around the 'cocos' tool, and treat the entirety of the actual cocos project as *intermediate code*.

* From the 'src', 'res' and 'myframeworks' folders, contents are *safely* copied and preprocessed, and source/resource definitions are auto-generated.  The release mode 'publish' outputs are also copied to a separate 'publish'.

* I made a convenient 'webdebug' publish.  It does the preprocessing, then collects the parts into one folder, so they're easy to zip up and give to someone else, for testing.

* If the build stops working, you can safely nuke the entirety of 'Example', and invoke 'ant init' again.  For an iOS build, you'll have to do the trivial poking around in XCode, to set up the certificate/mobileprovision, again.

* The preprocessing lets you trivially define certain 'hard' build constants, and heavily instrument the built source code, at no runtime cost.  Even define 'macros', if you are a 'sed head'.

[The Wiki Page](https://github.com/pingnak/AIRvsCocos/wiki) goes into more depth.

## Setup (over-simplified)

Get the source code.  

Make sure JAVA JDK and Apache ANT are installed.

In the root of the project...

    ant -f setup.xml

After a minor eternity of downloading/unzipping things, the 'android' tool will pop up.  Check off what you want, and let that finish downloading, too.

You'll want to edit the build.properties file(s).  Set up or override with your own keys/passwords, project name, etc.

Now initialize the Cocos project.

    cd Cocos
    ant init
    
At this point, you should be ready to go, except for iOS/Mac, which has some XCode tinkering.  That's still a mess.  

Android and Adobe AIR keys are auto-generated, if you don't provide one.

See the [Setup](https://github.com/pingnak/AIRvsCocos/wiki/Setup) wiki page.


It's not actually as hard as the length of it makes it look.  Well, except the iOS key stuff on the Windows side.

## System Requirements

### General

Some latter day version of Windows, OS X, or Ubuntu Linux 14.04

Recent JAVA JDK, Ant

The rest of the dependencies should be scripted. 

### Cocos2d-js

Windows build targets require Microsoft Visual Studio 2012 or later.

OS X and iOS build targets require Apple OS X 10.7+ and XCODE 5.1+ (from the App Store) 

Linux target requires more work, in a new virtual machine.  I could build Android from Linux, but the Linux side builds, but won't run in my virtual machine.

http://www.cocos2d-x.org/wiki/Cocos2d-x

https://github.com/cocos2d/cocos2d-js/blob/develop/LICENSE

### Adobe AIR SDK

For iOS, Android, or Adobe AIR targets, Mac or Windows will work, with the same project.

For a Windows Native installer (a 'setup.exe'), you need to build from Windows.  For an OS X Native installer (a 'setup.dmg'), you need to build from OS X.  If Adobe AIR runtime is installed, it can handle installing a '.air' app made under Windows or OS X for you. 

In Flash its self, there are discrepancies in how Windows vs. Mac versions render fonts into the output, so at least be aware of that.

http://www.adobe.com/products/air/tech-specs.html

http://www.adobe.com/products/air/sdk-eula.html

Other than that, and some other minor tinkering and caveats, one simple SDK does it all.

[Adobe AIR SDK](https://github.com/pingnak/AIRvsCocos/wiki/AIR)

## License

It's just a bunch of build scripts.  I don't care what you do with them.  Don't blame me if you can't use them right, or something blows up in your face.  If you hate me for it, consider that I'll be using them, too, so maybe that's its own punishment.

The Example bits and pieces in the Cocos half belong to the Cocos people, and their licensing, at least until I adapt my own, dumb 'Example' for that side of the build.
