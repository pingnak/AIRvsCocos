Instead of digging around among intermediate files, the various
loading/icons/etc. customizeable images and configuration text files and data 
are stored here.

They will be incrementally copied to the places where they're needed, each
time you build.  These are populated by 'ant init'.  Make sure they're under
version control, if you change out the Cocos2D-js API for a different version,
and have to invoke 'ant init', again.

The app stores have various kinds of requirements for icons, but most want a
512x512 icon.  When it's time to publish, you'll need a bunch of screen captures
and art cobbled together, all at once.

This may help you get your screen shots easily.  It will set various window sizes,
and then run the web version, which should be identical to 'whatever' versions.  

https://developers.google.com/web/fundamentals/tools/devices/browseremulation?hl=en

Here are some tools I googled around for.  There are many more.

Photoshop App Icon and Screenshot Templates for OSX/iOS/Android

http://appicontemplate.com

An icon and open screen making app for apple targets, including ios launch
images.  

https://itunes.apple.com/us/app/asset-catalog-creator-app/id809625456?mt=12

Real Favicon Generater (Makes a variety of web icons, for many devices).

http://realfavicongenerator.net/

Favic-o-matic

http://www.favicomatic.com/

