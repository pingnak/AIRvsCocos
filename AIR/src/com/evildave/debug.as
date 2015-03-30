
package com.evildave
{
    import flash.display.*;
    import flash.text.*;
    import flash.events.*;
    import flash.utils.*;

    public class debug
    {
        public static var ErrorSeparator : String = "\n#*\n#*----------------------------------------------------------------\n#*\n";
        
        /**
         * Log something to trace that will not be removed from release runtime
         * @param str Something to debug.Log (CORRECT trace-like behavior)
         * @param filter (OPTIONAL) Something for the incredibly slow debug.Log console to filter on
        **/
        public static function Log( ...rest ) : void
        {
            var sz : String = "\n";
            var i : int;
            for( i = 0; i < rest.length; ++i )
                sz += rest[i]+" ";

            // For debug build, emit in trace output, as well
            rest.unshift( "Log:" );
            trace.apply(NaN,rest );
        }

        /**
         * Log something to trace that will not be removed from release runtime
         * and make sure it's noticeable.
         * @param ...rest All the stuff you'd dump into trace
        **/
        public static function LogError( ...rest ) : void
        {
            rest.unshift( ErrorSeparator );
            Log.apply(NaN,rest );
        }
        
        /**
         * Trace some text - SHOULD BE an inline macro that eats trace statements
         * since it can't be (for CONFIG, anyway), disable it in release code.
         * @param rest Takes the same things as trace does
        **/
        public static function Trace( ...args ) : void
        {
CONFIG::DEBUG {
            trace.apply(NaN,args);
}
        }
        
        /**
         * Tell us what line/file Flash is running right here.
         * @param s If passed, tells us something about this line
        **/
        public static function TraceLine(s:*="") : void
        {
CONFIG::DEBUG {
            var err : Error = new Error();
            var dump : String = err.getStackTrace();
            Trace( 'traceline('+s+')' );
            TraceStack(1,1); // Trace one line, skipping TraceLine
}
        }

        /**
         * Tell us what Flash has on the stack
         * @param skipdepth How many things to skip (adds 2 to skip its self)
         * @param max Maximum depth to emit
        **/
        public static function TraceStack(skipdepth:int = 0,max:int=100) : void
        {
CONFIG::DEBUG {
            var err : Error = new Error();
            var dump : String = err.getStackTrace();
            var ats : Array = dump.split('\n');
            ats = ats.slice(2+skipdepth); // Error and top of stack (TraceStack)
            while( null != (dump = ats.shift()) && max--)
            {
                Trace(dump);
            }
}
        }

        /**
         * Dump public contents of an Object/Dictionary/Array
         * @param o Object to trace publicly accessible contents of
         * @param s If passed, tells us something about this object
        **/
        public static function TraceObject( o:*, s:* = "" ) : void
        {
CONFIG::DEBUG {
            { CONFIG::DEBUG { trace(s+": "+o ); } }
            if( o is XML )
            {
                { CONFIG::DEBUG { trace(o.toXMLString() ); } }
            }
            else
            {
                for( var m:String in o )
                {
                    { CONFIG::DEBUG { trace("    " + m + ": " + o[m] ); } }
                }
            }
}
        }

        /**
         * If condition is false, throw an assertion - SHOULD BE an inline macro.  
         * Surround your assertion code with CONFIG::DEBUG if it is extensive,
         * since without preprocessing, the calling code for assert will still 
         * happen, even though it's ignored.
         * i.e. CONFIG::DEBUG { { CONFIG::DEBUG { import flash.debugger.enterDebugger; if( !(something that takes a long time ) ) { trace('Assertion Failed: something that takes a long time ' ); enterDebugger(); } } } }
         * @param cond Condition to test
         * @param s Additional info to report about failed test
        **/
        public static function Assert( cond : Boolean, ...rest ) : void
        {
CONFIG::DEBUG {
            if( !cond )
            {
                import flash.debugger.enterDebugger;
                rest.unshift("ASSERTION FAILURE:");
                trace.apply(NaN,rest);
                TraceStack(1); // Skip the Assert function
                enterDebugger();
            }
}
        }

        /**
         * Trace assertion failure, jump into debug mode if in debugger
         * @param s Additional info to report about assertion
        **/
        public static function ThrowAssert(...args) : void
        {
CONFIG::DEBUG {
            import flash.debugger.enterDebugger;
            args.unshift("ASSERTION FAILURE:");
            trace.apply(NaN,args);
            TraceStack(1); // Skip the ThrowAssert function
            enterDebugger();
}
        }

        /**
         * Trace a display object container and all of its children
         * @param dobjtop Where to start tracing
        **/
        public static function TraceDisplayObjects( dobjtop : DisplayObject ) : void
        {
CONFIG::DEBUG {
            DObj.RCall(dobjtop,traceit);
            function traceit(dobj:DisplayObject):void
            {
                var depth : String = "";
                var p : DisplayObject = dobj;
                while( null != p.parent && p.parent != dobjtop )
                {
                    p = p.parent;
                    depth = depth + " ";
                }
                { CONFIG::DEBUG { trace(depth, dobj.name, getQualifiedClassName(dobj), dobj.x, dobj.y ); } }
            }
}
        }

        /**
         * Trace common download status events
        **/
        public static function TraceDownload( loader : EventDispatcher ) : void
        {
            if( loader is Loader )
                loader = (loader as Loader).contentLoaderInfo;
            loader.addEventListener( IOErrorEvent.IO_ERROR, LogError );
            loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, LogError );
CONFIG::DEBUG {
            loader.addEventListener( Event.OPEN, trace );
            loader.addEventListener( Event.COMPLETE, trace );
            loader.addEventListener( Event.INIT, trace );
            loader.addEventListener( HTTPStatusEvent.HTTP_STATUS, trace );
            // loader.addEventListener( ProgressEvent.PROGRESS, trace );
}
        }
    }
}
