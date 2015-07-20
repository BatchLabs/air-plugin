package com.batch.ane
{
	import flash.events.StatusEvent;

	public final class BatchUnlock
	{
		private static var instance:BatchUnlock = new BatchUnlock();
		
		// ------------------------------------->
		
		internal static function onEvent(event:StatusEvent):void
		{
			
		}
		
		// ------------------------------------->
		
		/**
		 * Set the listener for automatic unlock events<br/>
		 * You should call this method before calling start.
		 * 
		 * @param listener
		 */
		public static function setUnlockListener(listener:BatchUnlockListener):void
		{
			trace("BatchUnlock.setUnlockListener called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
		
		/**
		 * Set the listener for URL scheme opening events<br>
		 * You must set this listener before calling start
		 * 
		 * @param urlListener
		 */
		public static function setURLListener(urlListener:BatchURLListener):void
		{
			trace("BatchUnlock.setURLListener called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}

		
		/**
		 * Use the given code to provide gifts to the users<br/>
		 * This method will do nothing if you call it with a null codeListener
		 * 
		 * @param code
		 * @param listener listener to receive code response
		 */
		public static function redeemCode(code:String, codeListener:BatchCodeListener):void
		{
			trace("BatchUnlock.redeemCode called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
		
		/**
		 * Restore previously unlocked feature by the user<br/>
		 * This method will do nothing if you call it with a null restoreListener
		 * 
		 * @param listener listener to receive restore status (all methods will be called on the UI thread)
		 */
		public static function restore(restoreListener:BatchRestoreListener):void
		{
			trace("BatchUnlock.restore called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
	}
}