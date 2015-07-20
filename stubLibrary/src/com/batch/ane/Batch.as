package com.batch.ane
{
	import flash.events.EventDispatcher;
	
	public final class Batch extends EventDispatcher
	{
		/**
		 * Default ad placement
		 */
		public static const DEFAULT_PLACEMENT : String = "DEFAULT";
		
		// ------------------------------------->
		
		private static var instance:Batch = new Batch();
		
		// ------------------------------------->
		
		public function Batch()
		{
			
		}
		
		// -------------------------------------->
		
		public static function start(config:Config):void
		{
			trace("Batch.start called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
		
		public static function getUserProfile():BatchUserProfile
		{
			return new BatchUserProfile();
		}
	}
}