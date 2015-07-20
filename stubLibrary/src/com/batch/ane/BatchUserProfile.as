package com.batch.ane
{
	public class BatchUserProfile
	{		
		public function BatchUserProfile()
		{

		}
		
		// -------------------------------------------->
		
		/**
		 * Set the language of this user.<br />
		 * Setting this will affect targeting of this user, use it only if you know what you're doing.
		 * 
		 * @param language a string that represent a locale language (ex: fr, en, pt, ru etc...)
		 * @return
		 */
		public function setLanguage(language:String):BatchUserProfile
		{
			trace("BatchUserProfile.setLanguage called from a simulator. You're running a stub implementation that will not work with the real Batch server");
			return this;
		}
		
		/**
		 * Get the current language of this user.<br />
		 * If you set a custom one using {@link #setLanguage(String)} this method will return this one
		 * otherwise it will return the device default.
		 * 
		 * @return
		 */
		public function getLanguage():String
		{
			trace("BatchUserProfile.getLanguage called from a simulator. You're running a stub implementation that will always return 'en'");
			return "en";
		}
		
		/**
		 * Set the region (country) of this user.<br />
		 * Setting this will affect targeting of this user, use it only if you know what you're doing.
		 * 
		 * @param region a string that represent a locale region (country) (ex: FR, US, BR, RU etc...)
		 * @return
		 */
		public function setRegion(region:String):BatchUserProfile
		{
			trace("BatchUserProfile.setRegion called from a simulator. You're running a stub implementation that will not work with the real Batch server");
			return this;
		}
		
		/**
		 * Get the current region of this user.<br />
		 * If you set a custom one using {@link #setRegion(String)} this method will return this one
		 * otherwise it will return the device default.
		 * 
		 * @return
		 */
		public function getRegion():String
		{
			trace("BatchUserProfile.getRegion called from a simulator. You're running a stub implementation that will always return 'US'");
			return "US";
		}
		
		/**
		 * Set the custom user identifier to Batch.<br />
		 * You should use this method if you have your own login system.<br />
		 * <br />
		 * <b>Be carefull</b> : Do not use it if you don't know what you are doing,
		 * giving a bad custom user ID can result in failure into offer delivery and restore<br />
		 * 
		 * @param customID
		 */
		public function setCustomID(customID:String):BatchUserProfile
		{
			trace("BatchUserProfile.setCustomID called from a simulator. You're running a stub implementation that will not work with the real Batch server");
			return this;
		}
		
		/**
		 * Return the custom ID of the user if you specified any using the {@link #setCustomID(String)}
		 * 
		 * @return customID if any, null otherwise
		 */
		public function getCustomID():String
		{
			trace("BatchUserProfile.getCustomID called from a simulator. You're running a stub implementation that will always return null");
			return null;
		}
	}
}