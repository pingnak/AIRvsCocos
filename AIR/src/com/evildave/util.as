
/**
 * Dumping ground for utility functions
**/
package com.evildave
{
    import flash.display.*;
    public class util
    {
        /**
         * Do a quick shuffle of an array, in place
         **/
        public static function Shuffle( a:Array ) : Array
        {
            var i : int;
            var r : int;
            var tmp : *;
            var len : uint = a.length;
            // Front to back
            for( i = 0; i < len; ++i )
            {
                r = Math.floor( Math.random() * len );
                tmp = a[i];
                a[i] = a[r];
                a[r] = tmp;
            }
            // Back to front
            while( 0 < i-- )
            {
                r = Math.floor( Math.random() * len );
                tmp = a[i];
                a[i] = a[r];
                a[r] = tmp;
            }
            return a;
        }
        
        /**
         * Make an array of indexes, and shuffle it
         **/
        public static function ShuffleIndex( min:int, max:int ) : Array
        {
            var i : int;
            var ret : Array = new Array();
            for( i = min; i <= max; ++i )
                ret.push(i);
            return Shuffle(ret);
        }
        
        /**
         * Perform a breadth-first callback of display objects
         * This finds everything in order, from lowest depth, to topmost.
         *
         * @param dobj Start of DisplayObject tree search 
         * @param callback Function(DisplayObject) : Boolean - return true to stop at current display object
         * @return DisplayObject that callback stopped at, or null if we recursed all and didn't find it
        **/
        public static function DObjBreadthFirst( dobj : DisplayObject, callback : Function ) : DisplayObject
        {
CONFIG::DEBUG { debug.Assert( null != dobj ); }
CONFIG::DEBUG { debug.Assert( null != callback ); }
            var dCurr : DisplayObject;
            var dContain : DisplayObjectContainer;
            var i : int;
            var fifo : Array = new Array();
            fifo.push(dobj);
            while( 0 != fifo.length )
            {
                dCurr = fifo.shift(); // Remove earliest entries, first
                if( callback(dCurr) )
                    return dCurr;
                if( dCurr is DisplayObjectContainer )
                {
                    dContain = dCurr as DisplayObjectContainer;
                    for( i = 0; i < dContain.numChildren; ++i )
                    {
                        fifo.push(dContain.getChildAt(i));
                    }
                }
            }
            return null;
        }
        
        /**
         * Perform a recursive, depth-first callback of display objects
         * @param dobj Start of DisplayObject tree search 
         * @param callback Function(DisplayObject) : Boolean - return true to stop at current display object
         * @return DisplayObject that callback stopped at, or null if we recursed all and didn't find it
        **/
        public static function DObjDepthFirst( dobj : DisplayObject, callback : Function ) : DisplayObject
        {
CONFIG::DEBUG { debug.Assert( null != dobj ); }
CONFIG::DEBUG { debug.Assert( null != callback ); }
            var dContain : DisplayObjectContainer;
            var dCurr : DisplayObject;
            var i : int;
            if( dobj is DisplayObjectContainer )
            {
                dContain = dobj as DisplayObjectContainer;
                for( i = 0; i < dContain.numChildren; ++i )
                {
                    dCurr = DObjDepthFirst(dContain.getChildAt(i),callback);
                    if( null != dCurr )
                        return dCurr;
                }
            }
            if( callback(dobj) )
                return dobj;
            return null;
        }
        
    }
}