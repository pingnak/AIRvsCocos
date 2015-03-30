
package com.evildave
{
    import flash.utils.*;
    import flash.geom.*;
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import flash.media.*;
    import flash.filters.*;
	import com.evildave.*;

    /**
     * DisplayObject Utilities
     * <br/><br/>
     * Dumping ground for all kinds of DisplayObject utilities and oddities
     * <br/><br/>
     * If you don't some of this in your project, be sure to dike it out.
    **/
    public class DObj
    {
        /**
         * Recursively search for a DisplayObject with the given name. 
         * @param dobj Where to begin searching in the tree
         * @param name Name of DisplayObject to find
         * @return The DisplayObject or null if not found
        **/
        public static function RFind( dobj : DisplayObject, name : String, failOK : Boolean = false ) : DisplayObject
        {
            // Don't be bogus
            CONFIG::DEBUG { debug.Assert(null != dobj); }
            var ret : DisplayObject = _RFind( dobj, name );
            // Be sure to spot the errors finding things, before we get too far along
            CONFIG::DEBUG { debug.Assert( failOK || null != ret ); }
            return ret;
        }

        /**
         * Recursively search for a MovieClip with the given name.  Fails if not a MovieClip. 
         * @param dobj Where to begin searching in the tree
         * @param name Name of DisplayObject to find
         * @return The DisplayObject or null if not found
        **/
        public static function RFindMovieClip( dobj : DisplayObject, name : String ) : MovieClip
        {
            // Don't be bogus
            CONFIG::DEBUG { debug.Assert(null != dobj); }
            var dobjCurr : DisplayObject = _RFind( dobj, name );
            // Needs to exist
            CONFIG::DEBUG { debug.Assert( null != dobjCurr ); }
            var ret : MovieClip = dobjCurr as MovieClip;
            // Needs to be right class
            CONFIG::DEBUG { debug.Assert( null != ret ); }
            return ret;
        }

        /**
         * Recursively search for a TextField with the given name.  Fails if not a TextField. 
         * @param dobj Where to begin searching in the tree
         * @param name Name of DisplayObject to find
         * @return The DisplayObject or null if not found
        **/
        public static function RFindTextField( dobj : DisplayObject, name : String ) : TextField
        {
            // Don't be bogus
            CONFIG::DEBUG { debug.Assert(null != dobj); }
            var dobjCurr : DisplayObject = _RFind( dobj, name );
            // Needs to exist
            CONFIG::DEBUG { debug.Assert( null != dobjCurr ); }
            var ret : TextField = dobjCurr as TextField;
            // Needs to be right class
            CONFIG::DEBUG { debug.Assert( null != ret ); }
            return ret;
        }
        
        private static function _RFind( dobj : DisplayObject, name : String ) : DisplayObject
        {
            var dobjfound : DisplayObject = null;
            if( dobj.name == name )
                return dobj;
            if( dobj is DisplayObjectContainer )
            {
                // Two passes - don't recurse into grandchildren until top-level
                // children have been checked.  Most of the time, the thing 
                // we're scanning for isn't in the deepest of the depths.
                var dobjc : DisplayObjectContainer = dobj as DisplayObjectContainer;
                var child : DisplayObject;
                var i : int = dobjc.numChildren;
                while( 0 < i-- )
                {
                    child = dobjc.getChildAt(i);
                    // First test shouldn't be needed, but for some reason it is
                    if( null != child && child.name == name ) 
                    {  // Matched a child
                        return child;
                    }
                }
                i = dobjc.numChildren;
                while( 0 < i-- )
                {
                    child = dobjc.getChildAt(i);
                    if (null != child && child is DisplayObjectContainer)
                    { // Recurse into grandchildren
                        dobjfound = _RFind( child, name );
                        if( null != dobjfound )
                            return dobjfound;
                    }
                    else if( child is SimpleButton )
                    { // Recurse into button states looking for matches
                        var bn : SimpleButton = child as SimpleButton;
                        dobjfound = _RFind(bn.upState, name);
                        if( null != dobjfound )
                            return dobjfound;
                        dobjfound = _RFind(bn.overState, name);
                        if( null != dobjfound )
                            return dobjfound;
                        dobjfound = _RFind(bn.downState, name);
                        if( null != dobjfound )
                            return dobjfound;
                        dobjfound = _RFind(bn.hitTestState, name);
                        if( null != dobjfound )
                            return dobjfound;
                    }
                }
            }
            return dobjfound;
        }

        
        /**
         * Recursively call some function against a tree of objects
         * @param dobj Starting DisplayObject for recursion
         * @param fcall Function to call on each (passed as only parameter)
        **/
        public static function RCall( dobj : DisplayObject, fcall : Function ) : void
        {
            CONFIG::DEBUG { debug.Assert(null != dobj); }
            fcall(dobj);
            if( dobj is DisplayObjectContainer )
            {
                var dobjc : DisplayObjectContainer = dobj as DisplayObjectContainer;
                var i : int = dobjc.numChildren;
                while( 0 < i-- )
                {
                    try
                    {
                        var child : DisplayObject = dobjc.getChildAt(i);
                        if( null != child )
                        {
                            RCall( child, fcall );
                        }
                    }
                    catch( e:Error )
                    {
                        trace("Error recursing into",dobj.name);
                    }
                }
            }
            else if( dobj is SimpleButton )
            {   // Recurse into button states looking for matches
                var bn : SimpleButton = dobj as SimpleButton;
                RCall(bn.upState, fcall);
                RCall(bn.overState, fcall);
                RCall(bn.downState, fcall);
                RCall(bn.hitTestState, fcall);
            }
        }

        /**
         * Recursively call some function against a tree of objects
         * Skip the top-level one
         * @param dobj Starting DisplayObject for recursion
         * @param fcall Function to call on each (passed as only parameter)
        **/
        public static function RCall2( dobj : DisplayObject, call : Function ) : void
        {
            CONFIG::DEBUG { debug.Assert(null != dobj); }
            if( dobj is DisplayObjectContainer )
            {
                var dobjc : DisplayObjectContainer = dobj as DisplayObjectContainer;
                var i : int = dobjc.numChildren;
                while( 0 < i-- )
                {
                    var child : DisplayObject = dobjc.getChildAt(i);
                    RCall( child, call );
                }
            }
            else if( dobj is SimpleButton )
            {   // Recurse into button states looking for matches
                var bn : SimpleButton = dobj as SimpleButton;
                RCall(bn.upState, call);
                RCall(bn.overState, call);
                RCall(bn.downState, call);
                RCall(bn.hitTestState, call);
            }
        }

        /**
         * Reset a MovieClip (and all children) back to frame 1
         * @param dobj Starting DisplayObject for recursion
         * @param frame Where to reset the frames to (default = 1)
        **/
        public static function ResetClips( dobj : DisplayObject, frame : * = 1 ) : void
        {
            RCall( dobj, reset );
            function reset(dobj:DisplayObject):void
            { 
                try
                {
                    if( dobj is FSM )
                    {
                        (dobj as FSM).Reset();
                    }
                    if( dobj is MovieClip )
                    {
                        (dobj as MovieClip).stop();
                        MCM.Stop(dobj as MovieClip);
                        MCE.Disable(dobj as MovieClip);
                    }
                    if( dobj is Bitmap )
                    {
                        (dobj as Bitmap).bitmapData = null;
                    }
                }
                catch(e:*){}
            }
        }

        /**
         * Stop a MovieClip (and all of its children), wherever it is
         * @param dobj Starting DisplayObject for recursion
        **/
        public static function StopClips( dobj : DisplayObject ) : void
        {
            RCall( dobj, stopclip );
            function stopclip(dobj:DisplayObject) : void
            {
                try
                {
                    if( dobj is MovieClip ) 
                        (dobj as MovieClip).stop();
                }
                catch(e:*){}
            }
        }
        
        /**
         * Wipe out (and recursively stop) all children of a DisplayObject
         * @param dobj Starting DisplayObject for recursion
        **/
        public static function ClearChildren( dobj : DisplayObject ) : void
        {
            var child : DisplayObject;
            if( dobj is DisplayObjectContainer )
            {
                while( 0 != (dobj as DisplayObjectContainer).numChildren )
                {
                    try
                    {
                        child = (dobj as DisplayObjectContainer).removeChildAt(0);
                    }
                    catch(e:*){}
                    //ResetClips(child);
                }
            }
        }

        /**
         * Sort the children of DisplayObjectContainer, according to Array 
         * compatible compare function
         * @param container Container to sort
         * @param compare The rest of the params are passed to the Array.sort() function
        **/
        public static function SortChildren( container : DisplayObjectContainer, ...compare ) : void
        {
            var sorted : Array = [];
            var i : int;
            for( i = 0; i < container.numChildren; ++i )
            {
                sorted.push(container.getChildAt(i));
            }
            sorted = sorted.sort.apply(sorted,compare);
            for( i = 0; i < container.numChildren; ++i )
            {
                container.setChildIndex(sorted[i],i);
            }
            
        }
        
 
	}	
}