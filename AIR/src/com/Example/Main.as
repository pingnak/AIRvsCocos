package com.Example
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

    import com.evildave.*;
    
    public class Main extends MovieClip
    {
        private static var mainInstance : Main = null;
        private static var mouseInputOnApp : Boolean = false;
        private static var bPaused : Boolean = false;
        private static var pauseTime : Number = 0;
        private static var offsetTime : Number = 0;

        /** Get Main.instance */
        public static function get instance() : Main { return mainInstance; }

        /** Find out if mouse position is within app, while tracking mouse inputs */
        public static function get mouseInApp() : Boolean { return mouseInputOnApp; }

        /** Find out if app is paused */
        public static function get paused() : Boolean { return bPaused; }
        
        /** 
            Return game's millisecond clock; while paused, returns time we paused
            Will signed-int wrap after about 24 days, or 24 days since the interpreter
            first launched.
        **/
        public static function get timer() : Number { return (bPaused ? pauseTime : getTimer()) - offsetTime; } 
        
        /**
         * Main app entry point
        **/
        public function Main()
        {
            super();

            // Share our 'Main' instance
            CONFIG::DEBUG { debug.Assert( null == mainInstance ); }
            mainInstance = this;
            
            // Tell us about this build and this device.
            // Makes it easier to tell if QA has the right version.
            debug.Log( loaderInfo.url );
            CONFIG::DEBUG {
                debug.Log( "DEBUG BUILD: " + CONFIG::BUILD );
            }
            CONFIG::RELEASE {
                debug.Log( "RELEASE BUILD: " + CONFIG::BUILD );
            }
            debug.Log( Capabilities.os,Capabilities.playerType,Capabilities.version );
            debug.Log( Capabilities.serverString );

            if( null == stage )
            {
                addEventListener( Event.ADDED_TO_STAGE, OnStage );
            }
            else
            {
                OnStage();
            }
            addEventListener( Event.REMOVED_FROM_STAGE, OffStage );
        }
        
        /**
         * App has a stage, and is ready to go
        **/
        protected function OnStage(e:Event=null):void
        {
            offsetTime = getTimer();
            stage.addEventListener( Event.ENTER_FRAME, Cycle );
            stage.addEventListener( Event.RESIZE, Resize );
            stage.addEventListener( Event.ACTIVATE, Activate );
            stage.addEventListener( Event.DEACTIVATE, Deactivate );
            stage.addEventListener( MouseEvent.MOUSE_MOVE, MouseOn );
            stage.addEventListener( Event.MOUSE_LEAVE, MouseOff );
        }

        /**
         * Destroy the app
        **/
        protected function OffStage(e:Event=null):void
        {
            stage.removeEventListener( Event.ENTER_FRAME, Cycle );
            stage.removeEventListener( Event.RESIZE, Resize );
            stage.removeEventListener( Event.ACTIVATE, Activate );
            stage.removeEventListener( Event.DEACTIVATE, Deactivate );
            stage.removeEventListener( MouseEvent.MOUSE_MOVE, MouseOn );
            stage.removeEventListener( Event.MOUSE_LEAVE, MouseOff );

            CONFIG::DEBUG { debug.Assert( null != mainInstance ); }
            if( this == mainInstance )
                mainInstance = null;
        }

        /**
         * Main app heartbeat
        **/        
        protected function Cycle(e:Event=null):void
        {
            if( !bPaused )
                FSM.Cycle();
        }
        
        /**
         * App window size changed
        **/        
        protected function Resize(e:Event=null):void
        {
            // stage.stageWidth
            // stage.stageHeight
        }

        /**
         * App is focused/activated/shown
        **/        
        protected function Activate(e:Event=null):void
        {
            mouseInputOnApp = true;
            // Resume cycles
            bPaused = false;
            stage.addEventListener( Event.ENTER_FRAME, Cycle );

            // Fix game realtime clock
            offsetTime += getTimer() - pauseTime;
            pauseTime = 0;

            // Re-initialize keyboard handling
            // Resume music, if playing
        }

        /**
         * App doesn't have input focus
        **/        
        protected function Deactivate(e:Event=null):void
        {
            mouseInputOnApp = false;
            // Pause game
            bPaused = true;
            stage.removeEventListener( Event.ENTER_FRAME, Cycle );

            // Pause game realtime clock
            pauseTime = getTimer();

            // Re-initialize keyboard handling
            // Pause music, if playing
        }

        /**
         * Mouse cusor is over app 
        **/        
        protected function MouseOn(e:Event=null):void
        {
            mouseInputOnApp = true;
        }

        /**
         * Mouse cusor is outside app 
        **/        
        protected function MouseOff(e:Event=null):void
        {
            mouseInputOnApp = false;
        }
    }
}