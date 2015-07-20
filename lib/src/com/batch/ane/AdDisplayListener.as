package com.batch.ane
{
	public interface AdDisplayListener
	{
		/**
		 * Called when no ad has been displayed to the user.<br />
		 * It can happens if no ads are available or on error.<br />
		 * <br />
		 * <b>This method will be called on the UI Thread</b>
		 */
		function onNoAdDisplayed() : void;
		
		/**
		 * Called when the ad is displayed to the user.<br />
		 * <br />
		 * <b>This method will be called on the UI Thread</b>
		 */
		function onAdDisplayed() : void;
		
		/**
		 * Called when the previously displayed ad is closed.<br />
		 * <br />
		 * <b>This method will be called on the UI Thread</b>
		 */
		function onAdClosed() : void;
		
		/**
		 * Called when the user cancelled the ad.<br />
		 * This can be due to the used pressing either the close button or the back button.<br />
		 * {@link AdDisplayListener#onAdClosed()) will be called afterwards<br />
		 * <b>This method will be called on the UI Thread</b>
		 */
		function onAdCancelled() : void;
		
		/**
		 * Called when the user clicked the ad.<br />
		 * {@link AdDisplayListener#onAdClosed()) will be called afterwards<br />
		 * <br />
		 * <b>This method will be called on the UI Thread</b>
		 */
		function onAdClicked() : void;
	}
}