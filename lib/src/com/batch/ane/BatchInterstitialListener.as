package com.batch.ane
{
	public interface BatchInterstitialListener
	{
		/**
		 * Called when an interstitial is available for the given placement.
		 * 
		 * @param placementReference
		 */
		function onInterstitialReady(placementReference:String) : void;
		
		/**
		 * Called when no interstitial is available for the given placement.
		 * 
		 * @param placementReference
		 * @param error
		 */
		function onFailedToLoadInterstitial(placementReference:String, error:String) : void;
	}
}