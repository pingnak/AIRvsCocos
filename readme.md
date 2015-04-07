# Adobe AIR vs Cocos2d

This implements some build schemes for common middleware, based on recent work
with Cocos2D-js and Adobe AIR, specifically.

I decided to share because this is handy stuff, and I wanted a quick way to
start into either kind of project.

* Share a convenient Apache Ant build script for AIR SDK, which builds all of
the supported targets, and deploys/tests/debugs them.

* Document every step, from set up, to submit. This should be useful as an
example, for migrating between these environments, and keeping your code safe
and portable. Also, because I have old-people memory.

* I will make 'hands off' project scripts for Cocos2d-js, to keep the source
code, art, etc. from being scattered among tens of thousands of intermediate
garbage files, and corrects some nasty gotchas, present in version 3.3.

## Setup

Download and install Apache ANT first.  

http://ant.apache.org/bindownload.cgi
https://ant.apache.org/manual/platform.html

You'll have to do this one step manually.  Unzip it somewhere, and add it to your 
PATH.  For detailed instructions google 'How to install Apache Ant', with your
operating system name (Windows, OSX, Linux).

JAVA is required by ant, and almost everything else, too.

I had at least one manual download required for any platform I instaleld on, and
this made it nice and standard. Tools I need are all buried in ant. It's super
handy, though the syntax is a bit convoluted. Ant is needed for *everything*,
anyway. I think you'll need at least 1.8, or so. Current version, as of this
writing, is 1.9.4. So keep that in mind, if your earlier version of Ant chokes
and dies.

Once you have a local copy of this project through git, run the 'setup' script. 

ant -f setup.xml

The download is huge, and so are the file extractions.  At least you didn't have
to do them all by hand, while glued to the computer.  Ant can't resume a download
or 'fix' an archive, if you interrupt it.  So you'll have to clean out any 
intermediate, half baked stuff in the depends folder, if you stop it, or your
web connection gets dropped.

The setup script will generate a configuration for ANT, and a 'configure' 
script, to run from your shell.  The script is just there to be 'handy'.  Use
'source configure.sh', to load that configuration into BASH, or the like, or
invoke 'cnfigure.bat', for Windows CMD shell.  You don't need to do anything 
with it, to use the ant build.xml in either subdirectory.

At the end of the script, it will  launch the 'android' tool, to pick out other 
bits of the Android SDK, for the Cocos2D side of things, and review what you got, 
by default.  For instance, you need Android 5.0 SDK, or later, to support 
64 bit runtime.  The iOS side has similar requirements 5.1.1 was the first 
version compatible with an iPad.  The Cocos2d project has earlier iOS and Android 
SDK targets configured, and the respective app stores will bounce it as soon as 
you try to submit.

To play in the AIR folder, you're done, other than the certificate fun for iOS.
The AIR and Android .p12 files will be auto-generated.

In the Cocos folder, invoke 'ant init'.  This will create the Cocos2d project.  
Like the AIR version, the Android .p12 file will be auto-generated, if you
don't provide them.

Be sure to exclude that folder from your version control.  It has a couple of
leftover settings for iOS, but everything else will be generated.

If that Cocos2d project melts down, you can always delete that folder, and run 
'ant init' on it, again.  That is part of the reason why it's structured that 
way.  

## External Setup

For iOS things, the AIR SDK should work without any external dependencies. You
still have to jump through the iOS Developer hoops, but it works under Windows.  
Google for help, making .p12 from your developer certificate, and making and 
downloading a mobileprofile, to build with.  Configure it all in your 
build.properties.

For Cocos2D+iOS, you'll need to install XCODE from the OS X App Store, then
pick through the other bits that you need, within that mess of 
obscure, 'hideable' GUI mess.  Again, google for help if you take one look at 
that, and want to vomit.  It's not really that hard.

For Cocos2D+Android, we'll launch the Android tool for you from setup, and you 
can pick over the bits and pieces you needed.

On the Windows side of things, Cocos2D requires Visual Studio 2012, or later.  

## Platform Requirements

For Cocos2D, Windows type builds need Windows OS.  Mac/iOS builds need to run
in OS X.  Web or Android will work on either.

For AIR, you can generate AIR, Android or iOS files in Mac/Windows, but to make
the 'native installer' AIR application, Windows for Windows, Mac for Mac.

## The Sad Story of Linux + AIR

There isn't one.  At least, not an up-to-date one, with straight-forward 
installation rules.  So I'm setting that aside, and making sure Cocos2D-js
works, instead.

## Version Control

There are folders you shouldn't add to version control. For instance, the
'depends' folder, that 'setup' creates. Once it has extracted the archives,
there are literally over 100,000 little files and binaries in them. If you wish
to preserve the archives (since it's likely in the future that you might not be
able to download them again), back them up separately. Be selective of what you
add to version control, and 'exclude' the extracted folders. They can be
re-extracted, without forcing everyone to download that mountain of fecal matter
from version controlm again. Doing it *like this* (not necessarily *exactly like
this*), means you'll have the 'right' versions of everything, later on, when you
need to fix or change something.

The folder tree that happens after you invoke 'cocos new' is also full of crap
that you don't want in version control. Part of the reason I made these scripts
is to separate your code from those ten thousand pieces of intermediate crap,
and make reconstructing the project with new versions of Cocos2D, or on other
computers or platforms trivial. After all, if you want OS X and Windows and iOS
versions, Cocos must be run on OS X or Windows, to make the relevant versions.
Also, that big Cocos2d-js project is *immovable*. It has to stay right where the 
'Cocos2d console' put it.  Absolute paths are in there.  Beware.   Even if you 
copy from one computer of the same type, to another (another project team member, 
perhaps?), unless everything matches perfectly, you'll have some ugly issues.

Unfortunately, there are a couple of properties which live in the xcode project
in Cocos2d, that you'll probably have to endlessly tinker with in the xcode GUI, 
to change.

## A Note About Virtual Machines

It's super convenient to have a virtual machine.  VirtualBox (free) works on all 
platforms, and inexpensive programs, like Parallels (Mac) work really well.  
Setting something like this up, and building/testing on multiple projects is a 
big enough job, without setting up multiple, physical computers.

Also, a virtual machine makes an excellent project backup. After you put those
man-years of time and bushels of cash, blood sweat and tears into developing
something, about three years is the limit. That is, before the latest compiler
thinks your code is 'malformed', the tools, and everything else related to the
project either can't be found, or can't be installed on a modern machine
anymore. 

With this in mind, be sure to make a virtual machine as a 'snapshot' of the
development environment you used. It should contain the 'right' version of every
tool you ever used to edit art, animation, audio, code, and all of the APIs and 
dependencies to build it right, from scratch. Ten years from now, you should 
still be able to 'boot' that virtual machine, and you'll be damned glad you had 
it. It makes one file or folder of easily backed up content, and becomes a 
preconfigured art/sound/development environment in a can.

How cheap are terabytes of storage on external media?  Super cheap!  There's no
excuse.  MAKE them cough up the original contents.  It's inexcusable to have 
'flat' bitmaps or mp3 files, with all of the elements baked in.  It's the same as 
a programmer giving you an executable, but no source code.

Back it up properly. Nobody likes getting a bunch of stray bits and pieces, and
a job of piecing a game back together from that. Back up the PDF files with the
layers. Back up the raw sound and music multitrack projects with their samples.
The 3D models and meshes and textures and animations in the original format.
Back up the tools that know how to open it all, without *importing* 'old' data 
(in a buggy way), as well. Or you (or someone else) will suffer. It'll certainly
cost a lot less to make that 'minor update', or rebuild to support a new
platform, later on.

https://www.virtualbox.org/

Open source, so it will never disappear.

https://www.parallels.com/

Parallels is long established on OS X.  Really nice integration.  You need this,
if you have a Mac.

http://www.vmware.com/

VMWare.  Been around a long, long time.

http://www.microsoft.com/en-us/download/details.aspx?id=3702

Microsoft's thing.  I can't guarantee they'll continue to support it in six  
months, or whether it will support older VM files, later on.  That's just how 
they tend to operate with these 'accessories'.  It will work, right now, for now, 
and probably work well, like all of their developer tools.  For now.  Not a good 
tool to choose, for 'the future'.
