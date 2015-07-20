package com.batch.ane
{
	public final class CodeErrorInfoType
	{
		/**
		 * When the offer is paused.
		 */
		public static const OFFER_PAUSED:String = "OFFER_PAUSED";
		
		/**
		 * When the offer has already been acquired by this user.
		 */
		public static const OFFER_ALREADY_ACQUIRED:String = "OFFER_ALREADY_ACQUIRED";
		
		/**
		 * When a promocode has already been consumed by this user.
		 */
		public static const ALREADY_CONSUMED:String = "ALREADY_CONSUMED";
		
		/**
		 * When the offer is already capped.
		 */
		public static const OFFER_CAPPED:String = "OFFER_CAPPED";
		
		/**
		 * When the offer has expired.
		 */
		public static const OFFER_EXPIRED:String = "OFFER_EXPIRED";
		
		/**
		 * When the given code is unknown.
		 */
		public static const UNKNOWN_CODE:String = "UNKNOWN_CODE";
		
		/**
		 * When the user is missing some conditions.<br/>
		 * You should use {@link CodeErrorInfos#getMissingApplications()} to get the list of missing applications
		 */
		public static const MISSING_CONDITIONS:String = "MISSING_CONDITIONS";
		
		/**
		 * When your version of Batch library is not up to date and does not support this offer.
		 */
		public static const OFFER_UNSUPPORTED:String = "OFFER_UNSUPPORTED";
		
		/**
		 * When the Offer is not yet started
		 */
		public static const OFFER_NOT_STARTED:String = "OFFER_NOT_STARTED";
		
		/**
		 * When the user is not targeted by your Offer (ex: target only new users, etc...)
		 */
		public static const USER_NOT_TARGETED:String = "USER_NOT_TARGETED";
		
		/**
		 * When the server has an error or an invalid state.
		 * (ex: unable to retrieve an offer which should be retrievable)
		 */
		public static const SERVER_ERROR:String = "SERVER_ERROR";
	}
}