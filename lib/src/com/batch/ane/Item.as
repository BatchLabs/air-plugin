package com.batch.ane
{
	public class Item
	{
		/**
		 * Reference of the item
		 */
		private var reference:String;
		/**
		 * Reference of the bundle that contains this item
		 */
		private var bundleRef:String;

		// --------------------------------------->
		
		public function Item(reference:String, bundleRef:String)
		{
			if( !reference )
			{
				throw new Error("reference == null");
			}
			
			this.reference = reference;
			this.bundleRef = bundleRef;
		}
		
		// --------------------------------------->
		
		/**
		 * The reference of the item.
		 * 
		 * @return
		 */
		public function getReference():String
		{
			return reference;
		}
		
		/**
		 * Does this item come from a bundle
		 * 
		 * @return
		 */
		public function isInBundle():Boolean
		{
			return bundleRef != null;
		}
		
		/**
		 * Get the reference of the bundle that contains this feature
		 * 
		 * @return bundle reference if any, null otherwise
		 */
		public function getBundleReference():String
		{
			return bundleRef;
		}
	}
}