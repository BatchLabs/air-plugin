package com.batch.ane
{
	public final class Application
	{
		/**
		 * Scheme of the app
		 */
		private var scheme:String;
		/**
		 * Bundle id of the app
		 */
		private var bundleId:String;
		
		// -------------------------------------->
		
		public function Application(value:String, isScheme:Boolean)
		{
			if( !value )
			{
				throw new Error("value==null");
			}
			
			if( isScheme )
			{
				scheme = value;
			}
			else
			{
				bundleId = value;
			}
		}
		
		// -------------------------------------->
		
		/**
		 * Do we have a scheme for this app
		 * 
		 * @return
		 */
		public function hasScheme():Boolean
		{
			return scheme != null;
		}
		
		/**
		 * Get the scheme of the app
		 * 
		 * @return scheme if available, null otherwise
		 */
		public function getScheme():String
		{
			return scheme;
		}
		
		/**
		 * Do we have a bundle id for this app
		 * 
		 * @return
		 */
		public function hasBundleId():Boolean
		{
			return bundleId != null;
		}
		
		/**
		 * Get the bundle id of the app
		 * 
		 * @return bundle id if available, null otherwise
		 */
		public function getBundleId():String
		{
			return bundleId;
		}
	}
}