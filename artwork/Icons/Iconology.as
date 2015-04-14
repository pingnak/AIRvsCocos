package
{
	import flash.display.*;
    import flash.text.*;
	import flash.geom.*;
	import flash.system.*;
	import flash.media.*;
    import flash.events.*;
	import flash.utils.*;
	import flash.net.*;
    import flash.ui.*;

    import flash.desktop.NativeApplication;
    import flash.filesystem.*;
    import PNGEncoder;    
    
    /**
     * Edit the main MovieClip of the Flash file this is in.  
     *
     * Replace the icon with your icon, done as nice, scalable vector art
     *
     * As applicable, replace it in the timeline with 'low res' versions
    **/
    public class Iconology extends MovieClip
    {
        protected var xml : XML;
        var mcIcon : MovieClip;
        
        public function Iconology()
        {
            mcIcon = new Sizes();
            addChild(mcIcon);
            xml = XML(LoadText("Iconology.xml"));
            ParseFolders(xml);
        }
        
        protected function ParseFolders(xml:XML) : void
        {
            var root : File = File_AddPath( File.desktopDirectory, "Iconography" );
            root.createDirectory();

            var i : int;
            var children : XMLList = xml.children();
            for( i = 0; i < children.length(); ++i )
            {
                ParseFolder(root, children[i]);
            }
        }
        protected function ParseFolder(root:File, xml:XML) : void
        {
            var foldername : String = xml.name();
            var rootPath : File = File_AddPath( root, foldername );
            rootPath.createDirectory();
            
            var i : int;
            var children : XMLList = xml.elements("icon");
            for( i = 0; i < children.length(); ++i )
            {
                MakeIcons(rootPath, children[i]);
            }

        }
        protected function MakeIcons( root:File, xml:XML ) : void
        {
            var name : String = xml.@name;
            var type : String = name.substring( name.lastIndexOf('.') ).toLowerCase();
            var byteArray : ByteArray;
            if( '.ico' == type )
            {
                byteArray = MakeIcon(xml);
            }
            else
            {
                byteArray = MakePNG(xml);
            }

            var output : File = File_AddPath( root, name );
            var fs : FileStream = new FileStream();
            fs.open( output, FileMode.WRITE );
            fs.writeBytes(byteArray);
            fs.close();
        }
        
        /**
         * Make a .png file from XML definition
         * @param xml Details about the icon
         * @return ByteArray containing the icon file image
        **/
        protected function MakePNG( xml : XML ) : ByteArray
        {
            var baReturn : ByteArray = new ByteArray();
            var name : String = xml.@name;
            var size : int = parseInt(xml.@size);
            var area : int = parseInt(xml.@area);
            var fillSet : Boolean = "" == xml.@fill;
            var fill : uint = parseInt(xml.@fill,16);
            
            size = Math.min(size,1024);
            if( 0 == area )
                area = size;
            else
                area = Math.min(area,1024);

            /*
                I could scale it here, but then it becomes harder to have 
                'low resolution' versions.
            */
            var bmd : BitmapData = new BitmapData( area, area, true, fill );
            var center : Number = 0.5 * (area-size);
            var bmdMatrix : Matrix = new Matrix(1,0,0,1,center,center);
            mcIcon.gotoAndStop(size);
            bmd.draw( mcIcon, bmdMatrix, null, null, null, true );

            // Later versions of AIR SDK have PNGEncoder built in.
            //var pngEncode : PNGEncoder = new PNGEncoder();
            //baReturn = pngEncode.encode(bmd);
            baReturn = PNGEncoder.encode(bmd);
            
            bmd.dispose();
            
            return baReturn;
        }

        /**
         * Make a .ico file from XML definition
         * http://en.wikipedia.org/wiki/ICO_%28file_format%29
         * @param xml Details about the icon
         * @return ByteArray containing the icon file image
        **/
        protected function MakeIcon( xml : XML ) : ByteArray
        {
            var baReturn : ByteArray = new ByteArray();

            var size : String = xml.@size;
            var sizes : Array = size.split(',');
            var pngs : Array = new Array();
            
            // Generate pngs for each size
            var xmlTmp;
            var i : int;
            var j : int;
            while( 0 < sizes.length )
            {
                xmlTmp = xml.copy();
                size = sizes.shift();
                xmlTmp.@size = size;
                pngs.push(MakePNG(xmlTmp));
            }
            
            // Pre-calculate offsets needed by file
            const ImageDirEntrySize : uint = 16;
            const ICOHeaderSize : uint = 6;
            var imageDirOffset : uint = ICOHeaderSize + (pngs.length * ImageDirEntrySize);
            var imageOffset : Array = new Array();
            for( i = 0; i < pngs.length; ++i )
            {
                imageOffset.push(imageDirOffset);
                imageDirOffset += pngs[i].length;
            }

            // Windows formats are little-endian
            baReturn.endian = Endian.LITTLE_ENDIAN;
            
            // Write header
            baReturn.writeShort(0);
            baReturn.writeShort(1);
            baReturn.writeShort(pngs.length);

            // Write image directory entry
            for( i = 0; i < pngs.length; ++i )
            {
                baReturn.writeByte(int(size));
                baReturn.writeByte(int(size));
                baReturn.writeByte(0);
                baReturn.writeByte(0);
                
                baReturn.writeShort(0);
                baReturn.writeShort(32);
                
                baReturn.writeInt(pngs[i].length);
                baReturn.writeInt(imageOffset[i]);
            }

            // Write images
            for( i = 0; i < pngs.length; ++i )
            {
                baReturn.writeBytes(pngs[i]);
            }
            
            return baReturn;
        }
        
        /**
         * Load a text file
         * @param path Where to find the text
         * @return String containing the text
        **/
        protected static function LoadText( path:String ) : String
        {
            try
            {
                var root : File = File.applicationDirectory;
                var f : File = File_AddPath(root,path);
                if( f.exists && !f.isDirectory )
                {
                    var fs:FileStream = new FileStream();
                    fs.open(f, FileMode.READ);
                    var ret : String = fs.readUTFBytes(fs.bytesAvailable);
                    fs.close();
                    return ret;
                }
            }
            catch(e:Error)
            {
                trace(e);
            }
            return "";
        }

        /** Get path to folder containing this File, including its terminating '/' */
        protected static function File_AddPath( file : File, name:String = "" ) : File
        {
            var url : String = file.url;
            if( '/' == url.charAt(url.length-1) )
            {
                return new File(url + name);
            }
            return new File(url + '/' + name);
        }
        
    }
    
    
    
}
