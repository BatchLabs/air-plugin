package com.batch.ane
{
	public interface BatchURLListener
	{
		/**
		 * Called when the app has been opened with an URL scheme that contains a Batch promocode.<br />
		 * When this method is called, you'll be called on {@link #onURLCodeSuccess(String, Offer)} or {@link #onURLCodeFailed(String, FailReason, CodeErrorInfo)} in the near future.
		 * 
		 * @param code the code that was contained in the URL scheme
		 */
		function onURLWithCodeFound(code:String) : void;
		
		/**
		 * Called when the given code has been successfully validated<br />
		 * You should give all gifts contained in the {@link Offer} for the user.
		 * 
		 * @param code the code that was contained in the URL scheme
		 * @param offer The offer that contains gifts to unlock
		 */
		function onURLCodeSuccess(code:String, offer:Offer) : void;
		
		/**
		 * Called when the code contained in the url has failed.<br />
		 * 
		 * @param code the code that was contained in the URL scheme
		 * @param reason The reason of the failure
		 * @param infos More data about the failure reason
		 */
		function onURLCodeFailed(code:String, reason:String, infos:CodeErrorInfo) : void;
	}
}