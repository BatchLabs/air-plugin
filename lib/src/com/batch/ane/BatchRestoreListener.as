package com.batch.ane
{
	public interface BatchRestoreListener
	{
		/**
		 * Called when the restore has succeeded<br/>
		 * You should give back all features and resources to the user.
		 * 
		 * @param features Features to restore to the user
		 * @param resources Resources to restore to the user
		 */
		function onRestoreSucceed(features:Vector.<Feature>):void;
		
		/**
		 * Called when the restore has failed.
		 * 
		 * @param reason The reason of the failure
		 */
		function onRestoreFailed(reason:String):void; 
	}
}