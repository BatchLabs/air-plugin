package com.batch.ane
{
	import flash.external.ExtensionContext;

	public class BatchUserProfile
	{
		private var context:ExtensionContext;
		
		public function BatchUserProfile(context:ExtensionContext)
		{
			if( !context )
			{
				throw new Error( "context==null" );	
			}
			
			this.context = context;	
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
			if( language && language.length < 2 )
			{
				trace("BatchUserProfile : setLanguage called with invalid language (must be at least 2 chars)");
				return this;
			}
			
			var returnValue:Boolean = context.call("setUserLanguage", language) as Boolean;
			if( !returnValue )
			{
				trace("BatchUserProfile : An error occured while setting language");
			}
			
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
			return context.call("getUserLanguage") as String;
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
			if( region && region.length != 2 )
			{
				trace("BatchUserProfile : setRegion called with invalid language (must be 2 chars)");
				return this;
			}
			
			var returnValue:Boolean = context.call("setUserRegion", region) as Boolean;
			if( !returnValue )
			{
				trace("BatchUserProfile : An error occured while setting region");
			}
			
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
			return context.call("getUserRegion") as String;
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
			var returnValue:Boolean = context.call("setUserCustomID", customID) as Boolean;
			if( !returnValue )
			{
				trace("BatchUserProfile : An error occured while setting customID");
			}
			
			return this;
		}
		
		/**
		 * Return the custom ID of the user if you specified any using the {@link #setCustomID(String)}
		 * 
		 * @return customID if any, null otherwise
		 */
		public function getCustomID():String
		{
			return context.call("getUserCustomID") as String;
		}
	}
}