package com.batch.ane
{
	import flash.desktop.NativeApplication;
	import flash.events.EventDispatcher;
	import flash.events.InvokeEvent;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public final class Batch extends EventDispatcher
	{
		/**
		 * Default ad placement
		 */
		public static const DEFAULT_PLACEMENT : String = "DEFAULT";
		
		// ------------------------------------->
		
		private static var instance:Batch = new Batch();
		
		// ------------------------------------->
		
		private var extContext:ExtensionContext;
		
		// ------------------------------------->
		
		public function Batch()
		{
			extContext = ExtensionContext.createExtensionContext("com.batch.ane", "" );
			if ( !extContext ) 
			{
				throw new Error( "Batch SDK is not supported on this platform." );
			}
			
			extContext.addEventListener(StatusEvent.STATUS, onEvent);
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
		}
		
		private function onEvent(event:StatusEvent):void
		{
			// Register all modules
			BatchUnlock.onEvent(event);
			BatchPush.onEvent(event);
			BatchAds.onEvent(event);
		}
		
		private function onInvoke(event:InvokeEvent):void
		{
			if(event.arguments[0] != null) 
			{
				var arg : String = event.arguments[0];
				extContext.call("onSchemeFound", arg);
			}
		}
		
		// -------------------------------------->
		
		public static function getExtensionContext():ExtensionContext
		{
			return instance.extContext;
		}
		
		// -------------------------------------->
		
		/**
		 * Method to call when your app is starting. See documentation for more details.<br/>
		 * You must call this method before any other on Batch.
		 * 
		 * @param config the Batch config
		 */
		public static function start(config:Config):void
		{			
			if( !config )
			{
				trace("Batch.start called with null config, abording start");
				return;
			}
			
			if( !config.androidApikey && !config.iOSApiKey )
			{
				trace("Batch.start called with no API key. You should at least give one key for iOS or Android.");
				return;
			}
						
			instance.extContext.call("create", JSONMapper.configToJson(config));
		}
		
		/**
		 * Get the current user profile.<br />
		 * You should use this method if you want to modify user language/region or provide a custom ID to identify this user (like an account).<br />
		 * <br />
		 * <b>Be carefull</b> : Do not use it if you don't know what you are doing,
		 * giving a bad custom user ID can result in failure into offer delivery and restore<br />
		 * <br />
		 * You must call this method after start otherwise it will return null
		 * 
		 * @return instance of BatchUser to set properties, null if you call it before start. 
		 */
		public static function getUserProfile():BatchUserProfile
		{
			if( instance.extContext )
			{
				return new BatchUserProfile(instance.extContext);
			}
			
			return null;
		}
	}
}