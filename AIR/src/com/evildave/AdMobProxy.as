
package com.evildave
{
    import flash.display.*;
    import flash.text.*;
    import flash.events.*;
    import flash.utils.*;

CONFIG::ANDROID {
    import com.milkmangames.nativeextensions.*;
    import com.milkmangames.nativeextensions.events.*;    
}
    /**
     * AdMob wrapper for AdMob extension from http://www.milkmangames.com
     * No, I'm not putting up a copy of their library.  This gives an example
     * of harmlessly including the library, even when it isn't present.
     *
     * In this case, the code was left in a state where it only ran in Android
     * build.
     *
    **/
    public class AdMobProxy
    {
CONFIG::ANDROID {
        // In case you can't tell, that's a fake ID.
        private static const ADMOB_ID : String = "ca-app-pub-9999999999999999/9999999999";
        private static const ADMOB_INTERSTITIAL_ID : String = "ca-app-pub-9999999999999999/9999999999";
}
        // Set by 'live' ad server
        private static var _admobReady : Boolean = false;

        // Find out if this is working
        public static function get Enabled() : Boolean { return _admobReady; }

        /**
         * Initialize AdMob
        **/
        public static function AdMobInit() : Boolean
        {
CONFIG::ANDROID {
            if(!AdMob.isSupported)
            {
                debug.LogError("AdMob won't work on this platform!");
                return _admobReady = false;
            }
            try {
                AdMob.init(ADMOB_ID);
            }
            catch( e:Error ) {
                debug.LogError( "AdMob Failure\n"+e.toString() );
                return _admobReady = false;
            }
            
            
            /**********************************************
             * Remove this line when you're done testing! *
             **********************************************/
            AdMob.enableTestDeviceIDs(AdMob.getCurrentTestDeviceIDs());

            // Set our 'works' flag...            
            return _admobReady = true;
}
            return _admobReady = false;
        }

        /**
         * Show a banner ad
        **/
        public static function ShowBanner() : void
        {
CONFIG::ANDROID {
            if(!_admobReady)
                return;
            AdMob.showAd(AdMobAdType.SMART_BANNER, AdMobAlignment.CENTER, AdMobAlignment.TOP);
}
        }

        /**
         * Show a banner ad
        **/
        public static function PreloadInterstitial() : void
        {
CONFIG::ANDROID {
            if(!_admobReady)
                return;
            AdMob.loadInterstitial(ADMOB_INTERSTITIAL_ID, false);
}
        }

        /**
         * Show interstitial ad
        **/
        public static function ShowInterstitial(onDismiss:Function) : void
        {
CONFIG::ANDROID {
            if(!_admobReady)
                return;
            if( AdMob.isInterstitialReady() )
            {
                AdMob.showPendingInterstitial();
            }
            else
            {   // Just load another one, fresh
                AdMob.loadInterstitial(ADMOB_INTERSTITIAL_ID);
            }
            // Encapsulate callback for dismissal
            if( null != onDismiss )
            {
                AdMob.addEventListener( AdMobEvent.SCREEN_DISMISSED, OnDismissHandler );
            }
            function OnDismissHandler(e:Event):void
            {
                AdMob.removeEventListener(AdMobEvent.SCREEN_DISMISSED,OnDismissHandler);
                onDismiss();
            }
            return;
}
            if( null != onDismiss )
            {
                onDismiss();
            }
        }


        /**
         * Temporarily hide/show banner ad
        **/
        public static function SetVisibility( bVisible : Boolean = false ) : void
        {
CONFIG::ANDROID {
            if(!_admobReady)
                return;
            try {
                AdMob.setVisibility(bVisible);
            }
            catch(e:Error) {
                debug.LogError("No ad present to change visibility of!\n",e.toString());
            }
}
        }
        
        /**
         * Destroy the banner ad
        **/
        public static function RemoveBanner() : void
        {
CONFIG::ANDROID {
            if(!_admobReady)
                return;
            AdMob.destroyAd();
}
        }
    }
}
