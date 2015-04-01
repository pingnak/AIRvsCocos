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
    
    public class SmileyHandler extends MovieClip
    {
        private var mc : MovieClip;
        
        private var fsm: FSM;
        private var dx : Number;
        private var dy : Number;
        private var bounds : Rectangle;
        
        /**
         * Main app entry point
        **/
        public function SmileyHandler()
        {
            super();

            fsm = new FSM(this);

            mc = new Smiley();
            addChild(mc);
            bounds = new Rectangle( 0.5*mc.width, 0.5*mc.height, CONFIG::WIDE-mc.width, CONFIG::HIGH-mc.height ); 

            x = bounds.left + (Math.random() * bounds.width);
            y = bounds.top + (Math.random() * bounds.height);
            dx = -2 + (4 * Math.random());
            dy = -2 + (4 * Math.random());
            
            fsm.state = "Running";
        }
        
        /**
         * Just bounce it around.
        **/
        public function Running() : void
        {
            x += dx;
            y += dy;
            if( x >= bounds.right || x < bounds.left )
                dx = -dx;
            if( y >= bounds.bottom || y < bounds.top )
                dy = -dy;
        }
    }
}
