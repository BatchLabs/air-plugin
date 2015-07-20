package com.batch.ane
{
	public final class Resource extends Item
	{
		/**
		 * Quantity of the resource
		 */
		private var quantity:Number;
		
		// -------------------------------------->
		
		public function Resource(reference:String, bundleRef:String, quantity:Number)
		{
			super(reference, bundleRef);
			
			this.quantity = quantity;
		}
		
		// --------------------------------------->
		
		/**
		 * Get the quantity of 
		 * 
		 * @return
		 */
		public function getQuantity():Number
		{
			return quantity;
		}
	}
}