package com.batch.ane
{
	import flash.events.StatusEvent;

	public final class BatchPush
	{
		private static var instance:BatchPush = new BatchPush();
		
		// ------------------------------------->
		
		internal static function onEvent(event:StatusEvent):void
		{
			
		}
		
		// ------------------------------------->
		
		/**
		 * Set the GCM Sender Id for Android push (will do nothing on iOS). More infos : <a href="http://developer.android.com/google/gcm/gs.html#create-proj">Set-up GCM</a>
		 * 
		 * @param gcmSenderId Google API sender ID (for example: 670330094152)
		 */
		public static function setGCMSenderId(gcmSenderId:String) : void
		{
			trace("BatchPush.setGCMSenderId called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
		
		/**
		 * Dismiss all notifications shown by the application.<br />
		 * <br />
		 * You should call this method after starting Batch<br />
		 * <br />
		 * NB : This method will dismiss even not Batch notifications,
		 * this is a convenience method that you may not use if you
		 * have other notifications in your app.
		 */
		public static function dismissNotifications() : void
		{
			trace("BatchPush.dismissNotifications called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
		
		/**
		 * Reset badge count of your app icon (only on iOS, will do nothing on Android).
		 */
		public static function clearBadge() : void
		{
			trace("BatchPush.clearBadge called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
		
		/**
		 * Method to call to enable push registration.
		 */
		public static function registerForRemoteNotifications() : void
		{
			trace("BatchPush.registerForRemoteNotifications called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}

		/**
		 * Change the used remote notification types on iOS (will do nothing on Android).<br />
		 * You should use the bitwise value of IOSNotificationType (com.batch.ane.IOSNotificationType).<br />
		 * Default value is: IOSNotificationType.BADGE | IOSNotificationType.SOUND | IOSNotificationType.ALERT, you should not call this method is you don't want to change it.
		 */
		public static function setiOSNotificationTypes(type:uint) : void
		{
			trace("BatchPush.setiOSNotificationTypes called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
		
		/**
		 * Change the used remote notification types on Android (will do nothing on iOS).<br />
		 * You should use the bitwise value of AndroidNotificationType (com.batch.ane.AndroidNotificationType).<br />
		 * Default value is: AndroidNotificationType.VIBRATE | AndroidNotificationType.SOUND | AndroidNotificationType.ALERT | AndroidNotificationType.LIGHTS, you should not call this method is you don't want to change it.
		 */
		public static function setAndroidNotificationTypes(type:uint) : void
		{
			trace("BatchPush.setAndroidNotificationTypes called from a simulator. You're running a stub implementation that will not work with the real Batch server");
		}
	}
}