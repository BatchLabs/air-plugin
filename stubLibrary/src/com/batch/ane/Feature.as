package com.batch.ane
{
	public final class Feature extends Item
	{
		/**
		 * Value of the feature
		 */
		private var value:String;
		/**
		 * TTL of the feature
		 */
		private var ttl:Number = 0;
		
		// ------------------------------------->
		
		public function Feature(reference:String, bundleRef:String, value:String, ttl:Number=0)
		{
			super(reference, bundleRef);
			
			this.value = value;
			this.ttl = ttl;
		}
		
		// ------------------------------------->
		
		/**
		 * Get the value
		 * 
		 * @return value if provided, null otherwise
		 */
		public function getValue():String
		{
			return value;
		}
		
		/**
		 * Does it contains value
		 * 
		 * @return
		 */
		public function hasValue():Boolean
		{
			return value != null;
		}
		
		/**
		 * Does this feature is acquired for life by the user<br/>
		 * If this method returns false, you should retreive the time to live
		 * of the feature with the {@link #getTTL()} method
		 * 
		 * @return false if the feature is limited in time, true if lifetime
		 */
		public function isLifetime():Boolean
		{
			return ttl <= 0;
		}
		
		/**
		 * Get the time to live of the feature in seconds<br/>
		 * You are responsible of invalidating it after the given time is passed
		 * 
		 * @return time to live in seconds
		 */
		public function getTTL():Number
		{
			return ttl;
		}
		
	}
}