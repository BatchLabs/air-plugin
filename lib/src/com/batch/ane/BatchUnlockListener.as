package com.batch.ane
{
	public interface BatchUnlockListener
	{
		/**
		 * Called when an offer should be given to the user.
		 * 
		 * @param offer offer that contains features and resources to provide to the user
		 */
		function onRedeemAutomaticOffer(offer:Offer):void;
	}
}