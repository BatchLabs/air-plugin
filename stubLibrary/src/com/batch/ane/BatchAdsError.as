package com.batch.ane
{
	public class BatchAdsError
	{
		/**
		 * There were no network connexion to load an ad
		 */
		public static const NETWORK_ERROR : String = "NETWORK_ERROR";
		
		/**
		 * No ad is currently available for this placement, either you reach the cappings or this placement is disabled
		 */
		public static const NO_AD_AVAILABLE : String = "NO_AD_AVAILABLE";
		
		/**
		 * This placement is unknown, you should check your configuration on Batch dashboard
		 */
		public static const UNKNOWN_PLACEMENT : String = "UNKNOWN_PLACEMENT";
		
		/**
		 * An unexpected error occured
		 */
		public static const UNEXPECTED_ERROR : String = "UNKNOWN_PLACEMENT";
	}
}