package com.batch.ane
{
	import flash.events.StatusEvent;

	public final class BatchAds
	{
		private static var instance:BatchAds = new BatchAds();
		
		// ------------------------------------->
		
		internal static function onEvent(event:StatusEvent):void
		{
			
		}
		
		// ------------------------------------->
		
		/**
		 * Display an ad for the given placement if available
		 * 
		 * @param placementReference the placement reference you want to display an ad for
		 * 
		 * @return true on success, false when no ads are available
		 */
		public static function displayInterstitial(placementReference:String) : Boolean
		{
			trace("BatchAds.displayInterstitial called from a simulator. You're running a stub implementation that will not work with the real Batch server");
			return false;
		}
		
		/**
		 * Display an ad for the given placement if available
		 * 
		 * @param placementReference the placement reference you want to display an ad for
		 * @param listener the listener to receive show and close events
		 * 
		 * @return true on success, false when no ads are available
		 */
		public static function displayInterstitialWithListener(placementReference:String, listener:AdDisplayListener) : void
		{
			trace("BatchAds.displayInterstitialWithListener called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
		
		/**
		 * Set-up ads
		 */
		public static function setup(): void
		{
			trace("BatchAds.setup called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
		
		/**
		 * Method to check if an ad is available for the given placement at this time
		 * 
		 * @param placementReference
		 * 
		 * @return true if an ad is available, false is there's no ad available for this moment yet
		 */
		public static function hasInterstitialReady(placementReference:String) : Boolean
		{
			trace("BatchAds.hasInterstitialReady called from a simulator. You're running a stub implementation that will not work with the real Batch server");
			return false;
		}
		
		/**
		 * Should Batch load ads automaticaly. <br />
		 * Calling this method and passing no means that you're responsible of implementing
		 * {@link #load()} when your app start and every time a Batch ad is displayed, otherwise 
		 * you'll not have any ad available.
		 * 
		 * @param autoLoad true for autoload (default), false for manual load
		 */
		public static function setAutoLoad(autoLoad:Boolean) : void
		{
			trace("BatchAds.setAutoLoad called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
		
		/**
		 * Call this method to preload an ad to display. If you use auto load, calling this method will do nothing.
		 * 
		 * @param placementReference reference of the placement
		 * @param listener Listener to receive loading success and failure events
		 */
		public static function loadInterstitial(placementReference:String, listener:BatchInterstitialListener) : void
		{
			trace("BatchAds.loadInterstitial called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
	}
}