Images from frameworks/cocos2D-html5/Base64Images.js

See also: http://en.wikipedia.org/wiki/Data_URI_scheme

To encode an image (jpeg|png|gif)...

base64 src.png > dst.txt
uuencode -m src.png > dst.txt

In Windows, use certutil (Note: it dumps some crap into the file with the
uuencoded data):

certutil -encode src.png dst.txt

Carefully copy the 'SPEW' from the dst.txt, and paste it into Base64Images.js,
where you need it.  Also note that you need to edit the 'image/png',
'image/jpeg' and 'image/gif', to match the format of what you encoded. 

cc._fpsImage = "data:image/png;base64,SPEW";

To decode, carefully put the 'SPEW' into a file, without the extra 'data URI'
spew.

base64 -o src.png < src.txt
uudecode -o src.png < src.txt

In windows, again certutil:

certutil -decode src.txt dst.png

There are various 'online' encoder/decoders, too.  Google it.


