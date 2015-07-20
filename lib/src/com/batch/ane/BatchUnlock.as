package com.batch.ane
{
	import flash.events.StatusEvent;

	public final class BatchUnlock
	{
		private static var instance:BatchUnlock = new BatchUnlock();
		
		// ------------------------------------->
		
		private var batchListener:BatchUnlockListener;
		private var codeListener:BatchCodeListener;
		private var restoreListener:BatchRestoreListener;
		private var urlListener:BatchURLListener;
		
		// ------------------------------------->
		
		internal static function onEvent(event:StatusEvent):void
		{
			var json:Object = null;
			switch(event.level)
			{
				case "onRedeemOffer" :
				{
					try
					{
						if( !instance.batchListener )
						{
							trace("Batch : You redeemed an automatic Offer but you have no listener set-up. You should add an automatic unlock listener by calling BatchUnlock.setUnlockListener");
							return;
						}
						
						json = JSON.parse(event.code);
						instance.batchListener.onRedeemAutomaticOffer(JSONMapper.mapOffer(json));
					}
					catch(error:Error)
					{
						trace("An error occured during Batch runtime");
					}
					break;
				}
				case "onRedeemCodeSuccess" :
				{
					try
					{
						json = JSON.parse(event.code);
						instance.codeListener.onRedeemCodeSuccess(json.code, JSONMapper.mapOffer(json.offer));
					}
					catch(error:Error)
					{
						instance.codeListener.onRedeemCodeFailed(null, FailReason.UNEXPECTED_ERROR, null);
					}
					finally
					{
						instance.codeListener = null;
					}
					break;
				}
				case "onRedeemCodeFailed" :
				{
					try
					{
						json = JSON.parse(event.code);
						instance.codeListener.onRedeemCodeFailed(json.code, json.reason, JSONMapper.mapErrorInfos(json.infos));
					}
					catch(error:Error)
					{
						instance.codeListener.onRedeemCodeFailed(null, FailReason.UNEXPECTED_ERROR, null);
					}
					finally
					{
						instance.codeListener = null;
					}
					break;
				}
				case "onRestoreSucceed" :
				{
					try
					{
						json = JSON.parse(event.code);
						instance.restoreListener.onRestoreSucceed(JSONMapper.getFeaturesFromArray(json.feat));
					}
					catch(error:Error)
					{
						instance.restoreListener.onRestoreFailed(FailReason.UNEXPECTED_ERROR);
					}
					finally
					{
						instance.restoreListener = null;
					}
					break;
				}
				case "onRestoreFailed" :
				{
					try
					{
						instance.restoreListener.onRestoreFailed(event.code);
					}
					catch(error:Error)
					{
						instance.restoreListener.onRestoreFailed(FailReason.UNEXPECTED_ERROR);
					}
					finally
					{
						instance.restoreListener = null;
					}
					break;
				}
				case "onURLWithCodeFound" : 
				{
					try
					{
						instance.urlListener.onURLWithCodeFound(event.code);
					}
					catch(error:Error)
					{
						trace("An error occured during Batch runtime with URL listener");
					}
					break;
				}
				case "onURLCodeSuccess" : 
				{
					try
					{
						json = JSON.parse(event.code);
						instance.urlListener.onURLCodeSuccess(json.code, JSONMapper.mapOffer(json.offer));
					}
					catch(error:Error)
					{
						instance.urlListener.onURLCodeFailed(null, FailReason.UNEXPECTED_ERROR, null);
					}
					break;
				}
				case "onURLCodeFailed" : 
				{
					try
					{
						json = JSON.parse(event.code);
						instance.urlListener.onURLCodeFailed(json.code, json.reason, JSONMapper.mapErrorInfos(json.infos));
					}
					catch(error:Error)
					{
						instance.urlListener.onURLCodeFailed(null, FailReason.UNEXPECTED_ERROR, null);
					}
					break;
				}
			}
		}
		
		/**
		 * Set the listener for automatic unlock events<br/>
		 * You should call this method before calling start.
		 * 
		 * @param listener
		 */
		public static function setUnlockListener(listener:BatchUnlockListener):void
		{
			instance.batchListener = listener; 
		}
		
		/**
		 * Set the listener for URL scheme opening events<br>
		 * You must set this listener before calling start
		 * 
		 * @param urlListener
		 */
		public static function setURLListener(urlListener:BatchURLListener):void
		{
			instance.urlListener = urlListener;
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
			if( instance.codeListener )
			{
				trace("BatchUnlock.redeemCode called while a code is already being processed, abording");
				return;
			}
			
			if( !codeListener )
			{
				trace("BatchUnlock.redeemCode called with null BatchCodeListener, abording");
				return;
			}
			
			if( !code )
			{
				trace("BatchUnlock.redeemCode called with null code");
				codeListener.onRedeemCodeFailed(null, FailReason.UNEXPECTED_ERROR, null);
				return;
			}
			
			if( !instance.batchListener )
			{
				trace("BatchUnlock.redeemCode called without UnlockListener set. You must set an UnlockListener to use redeemCode");
				codeListener.onRedeemCodeFailed(null, FailReason.UNEXPECTED_ERROR, null);
				return;
			}
			
			instance.codeListener = codeListener;
			
			Batch.getExtensionContext().call("redeemCode", code);
		}
		
		/**
		 * Restore previously unlocked feature by the user<br/>
		 * This method will do nothing if you call it with a null restoreListener
		 * 
		 * @param listener listener to receive restore status (all methods will be called on the UI thread)
		 */
		public static function restore(restoreListener:BatchRestoreListener):void
		{
			if( instance.restoreListener )
			{
				trace("BatchUnlock.restore called while a restore is already being processed, abording");
				return;
			}
			
			if( !restoreListener )
			{
				trace("BatchUnlock.restore called with null BatchRestoreListener, abording");
				return;
			}
			
			if( !instance.batchListener )
			{
				trace("BatchUnlock.restore called without UnlockListener set. You must set an UnlockListener to use restore");
				restoreListener.onRestoreFailed(FailReason.UNEXPECTED_ERROR);
				return;
			}
			
			instance.restoreListener = restoreListener;
			
			Batch.getExtensionContext().call("restore");
		}
	}
}