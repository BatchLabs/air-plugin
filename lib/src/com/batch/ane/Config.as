package com.batch.ane
{
	public final class Config
	{
		/**
		 * The API key used for Batch on Android
		 */
		public var androidApikey:String;
		/**
		 * The API key used for Batch on iOS
		 */
		public var iOSApiKey:String;
		
		/**
		 * Should Batch use AndroidID or not
		 */
		public var shouldUseAndroidID:Boolean = true;
		/**
		 * Should Batch use Advertising ID or not
		 */
		public var shouldUseAdvertisingID:Boolean = true;
		/**
		 * Shoudl Batch use IDFA or not
		 */
		public var shouldUseIDFA:Boolean = true;
		
		// ----------------------------------------->
		
		/**
		 *
		 */
		public function Config()
		{
			
		}
		
		// ----------------------------------------->
		
		/**
		 * Set the Batch API Key to use on Android
		 * 
		 * @param apikey
		 */
		public function setAndroidAPIKey(apikey:String):Config
		{
			androidApikey = apikey;
			return this;
		}
		
		/**
		 * Set the Batch API Key to use on iOS
		 * 
		 * @param apikey
		 */
		public function setiOSAPIKey(apikey:String):Config
		{
			iOSApiKey = apikey;
			return this;
		}
		
		
		/**
		 * Set if Batch can use AndroidID (default = true)<br />
		 * <br />
		 * Setting this to false have a negative impact on offer delivery and restore<br />
		 * You should only use it if you know what you are doing.
		 * 
		 * @param canUse can Batch use AndroidID
		 */
		public function setCanUseAndroidID(canUse:Boolean):Config
		{
			shouldUseAndroidID = canUse;
			return this;
		}
		
		/**
		 * Set if Batch can use AvertisingId (default = true)<br />
		 * <br />
		 * Setting this to false have a negative impact on offer delivery and restore<br />
		 * You should only use it if you know what you are doing.
		 * 
		 * @param canUse can Batch use AdvertisingID
		 */
		public function setCanUseAdvertisingID(canUse:Boolean):Config
		{
			shouldUseAdvertisingID = canUse;
			return this;
		}
		
		/**
		 * Set if Batch can use IDFA on iOS (default = true)<br />
		 * <br />
		 * Setting this to false have a negative impact on offer delivery and restore<br />
		 * You should only use it if you know what you are doing.
		 * 
		 * @param setCanUseIDFA can Batch use IDFA
		 */
		public function setCanUseIDFA(canUseIDFA:Boolean):Config
		{
			shouldUseIDFA = canUseIDFA;
			return this;
		}
	}
}