package com.batch.ane
{
	public final class CodeErrorInfo
	{
		/**
		 * Type of the error infos
		 */
		private var type:String;
		
		/**
		 * Missing application (can be empty)
		 */
		private var missingApplications:Vector.<Application> = new Vector.<Application>();
		
		// --------------------------------------->
		
		public function CodeErrorInfo(type:String, missingApplications:Vector.<Application> = null)
		{
			if( !type )
			{
				throw new Error("type == null");
			}
			
			this.type = type;
			
			if( missingApplications )
			{
				this.missingApplications = this.missingApplications.concat(missingApplications);
			}
		}
		
		// --------------------------------------->
		
		/**
		 * Get code error infos type
		 * 
		 * @return
		 */
		public function getType():String
		{
			return type;
		}
		
		/**
		 * Does it contains missing applications
		 * 
		 * @return
		 */
		public function hasMissingApplications():Boolean
		{
			return missingApplications.length > 0;
		}
		
		/**
		 * Get the list of missing applications
		 * 
		 * @return an unmodifiable list
		 */
		public function getMissingApplications():Vector.<Application>
		{
			return missingApplications;
		}
	}
}