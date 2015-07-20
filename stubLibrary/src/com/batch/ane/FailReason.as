package com.batch.ane
{
	public final class FailReason
	{
		/**
		 * Network is not available or not responding
		 */
		public static const NETWORK_ERROR:String = "NETWORK_ERROR";
		/**
		 * Your API key is invalid
		 */
		public static const INVALID_API_KEY:String = "INVALID_API_KEY";
		/**
		 * Your API key has been deactivated
		 */
		public static const DEACTIVATED_API_KEY:String = "DEACTIVATED_API_KEY";
		/**
		 * The promocode is invalid
		 */
		public static const INVALID_CODE:String = "INVALID_CODE";
		/**
		 * An unexpected error occured, a future retry can succeed
		 */
		public static const UNEXPECTED_ERROR:String = "UNEXPECTED_ERROR";
		/**
		 * The requested code is not valid because we are not meeting conditions
		 */
		public static const MISMATCH_CONDITIONS:String = "MISMATCH_CONDITIONS";
	}
}