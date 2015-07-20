package com.batch.ane
{
	public interface BatchCodeListener
	{
		/**
		 * Called when the given code has been successfully validated<br/>
		 * You should provide all items contained in the Offer for the user.
		 * 
		 * @param code The entered code
		 * @param offer offer that contains gifts for the user
		 */
		function onRedeemCodeSuccess(code:String, offer:Offer):void;
		
		/**
		 * Called when the code redeem has failed.
		 * 
		 * @param code The entered code
		 * @param reason The reason of the failure
		 * @param infos More data about the failure reason (can be null)
		 */
		function onRedeemCodeFailed(code:String, reason:String, infos:CodeErrorInfo):void;
	}
}