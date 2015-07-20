package com.batch.ane
{
	import flash.events.StatusEvent;
	import flash.utils.Dictionary;

	public final class BatchAds
	{
		private static var instance:BatchAds = new BatchAds();
		
		// ------------------------------------->
		
		private var adDisplayListener:AdDisplayListener;
		private var adLoadingListeners:Dictionary = new Dictionary();
		
		// ------------------------------------->
		
		internal static function onEvent(event:StatusEvent):void
		{
			switch(event.level)
			{
				case "AdOnNoAdDisplayed" :
				{
					try
					{						
						if( instance.adDisplayListener )
						{
							instance.adDisplayListener.onNoAdDisplayed();
							instance.adDisplayListener = null;
						}
					}
					catch(error:Error)
					{
						trace("An error occured during Batch runtime");
					}
					break;
				}
				case "AdOnAdDisplayed" :
				{
					try
					{
						if( instance.adDisplayListener )
						{
							instance.adDisplayListener.onAdDisplayed();
						}
					}
					catch(error:Error)
					{
						trace("An error occured during Batch runtime");
					}
					break;
				}
				case "AdOnAdClosed" :
				{
					try
					{
						if( instance.adDisplayListener )
						{
							instance.adDisplayListener.onAdClosed();
							instance.adDisplayListener = null;
						}
					}
					catch(error:Error)
					{
						trace("An error occured during Batch runtime");
					}
					break;
				}
				case "AdOnAdClicked" :
				{
					try
					{
						if( instance.adDisplayListener )
						{
							instance.adDisplayListener.onAdClicked();
						}
					}
					catch(error:Error)
					{
						trace("An error occured during Batch runtime");
					}
					break;
				}
				case "AdOnAdCancelled" :
				{
					try
					{
						if( instance.adDisplayListener )
						{
							instance.adDisplayListener.onAdCancelled();
						}
					}
					catch(error:Error)
					{
						trace("An error occured during Batch runtime");
					}
					break;
				}
				case "onFailToLoadAdForPlacement" :
				{
					try
					{
						var json:Object = JSON.parse(event.code);
						if( instance.adLoadingListeners[json.placement] )
						{
							instance.adLoadingListeners[json.placement].onFailedToLoadInterstitial(json.placement, json.error);
							delete instance.adLoadingListeners[json.placement];
						}
					}
					catch(error:Error)
					{
						trace("An error occured during Batch runtime");
					}
					break;
				}
				case "onAdAvailableForPlacement" :
				{
					try
					{
						if( instance.adLoadingListeners[event.code] )
						{
							instance.adLoadingListeners[event.code].onInterstitialReady(event.code);
							delete instance.adLoadingListeners[event.code];
						}
					}
					catch(error:Error)
					{
						trace("An error occured during Batch runtime");
					}
					break;
				}
			}
		}
		
		// ------------------------------------->
		
		/**
		 * Display an interstitial for the given placement if available
		 * 
		 * @param placementReference the placement reference you want to display an ad for
		 * 
		 * @return true on success, false when no ads are available
		 */
		public static function displayInterstitial(placementReference:String) : Boolean
		{
			if( !placementReference )
			{
				trace("BatchAds.displayInterstitial called with null placement, abording");
				return false;
			}
			
			return Batch.getExtensionContext().call("adDisplay", placementReference) as Boolean;
		}
		
		/**
		 * Display an interstitial for the given placement if available
		 * 
		 * @param placementReference the placement reference you want to display an ad for
		 * @param listener the listener to receive show and close events
		 * 
		 * @return true on success, false when no ads are available
		 */
		public static function displayInterstitialWithListener(placementReference:String, listener:AdDisplayListener) : void
		{
			if( instance.adDisplayListener )
			{
				trace("BatchAds.displayInterstitialWithListener called while an ad is already displayed, abording");
				return;
			}
			
			if( !placementReference )
			{
				trace("BatchAds.displayInterstitialWithListener called with null placement, abording");
				return;
			}
			
			if( !listener )
			{
				trace("BatchAds.displayInterstitialWithListener called with null listener, abording");
				return;
			}
			
			instance.adDisplayListener = listener;
			
			Batch.getExtensionContext().call("adDisplayWithListener", placementReference);
		}
		
		/**
		 * Set-up ads
		 */
		public static function setup(): void
		{
			Batch.getExtensionContext().call("adSetup");
		}
		
		/**
		 * Method to check if an interstitial is available for the given placement at this time
		 * 
		 * @param placementReference
		 * 
		 * @return true if an ad is available, false is there's no ad available for this moment yet
		 */
		public static function hasInterstitialReady(placementReference:String) : Boolean
		{
			if( !placementReference )
			{
				trace("BatchAds.hasInterstitialReady called with null placement, returning false");
				return false;
			}
			
			return Batch.getExtensionContext().call("adHasInterstitialReady", placementReference) as Boolean;
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
			Batch.getExtensionContext().call("adSetAutoLoad", autoLoad);
		}
		
		/**
		 * Call this method to preload an interstitial to display. If you use auto load, calling this method will do nothing.
		 * 
		 * @param placementReference reference of the placement
		 * @param listener Listener to receive loading success and failure events
		 */
		public static function loadInterstitial(placementReference:String, listener:BatchInterstitialListener) : void
		{
			if( !placementReference )
			{
				trace("BatchAds.loadInterstitial called with null placement, abording");
				return;
			}
			
			if( !listener ) 
			{
				trace("BatchAds.loadInterstitial called with null listener, abording");
				return;
			}
			
			if( instance.adLoadingListeners[placementReference] )
			{
				trace("BatchAds.loadInterstitial while already loading for this placement, abording");
				return;
			}
			
			instance.adLoadingListeners[placementReference] = listener;

			Batch.getExtensionContext().call("adLoadForPlacement", placementReference);
		}
	}
}