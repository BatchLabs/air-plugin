package com.batch.ane
{
	import flash.utils.Dictionary;

	public final class Offer
	{
		/**
		 * Reference of the offer
		 */
		private var offerReference:String;
		/**
		 * Dictionnary of offer parameters
		 */
		private var offerAdditionalParameters:Dictionary = new Dictionary();
		/**
		 * List of Feature to unlock
		 */
		private var features:Vector.<Feature> = new Vector.<Feature>();
		/**
		 * List of Resource to unlock
		 */
		private var resources:Vector.<Resource> = new Vector.<Resource>();
		/**
		 * List of bundles this offer contains
		 */
		private var bundleReferences:Vector.<String> = new Vector.<String>();
		
		// ------------------------------------>
		
		public function Offer(reference:String, features:Vector.<Feature>, resources:Vector.<Resource>, bundleReferences:Vector.<String>, additionalParameters:Dictionary)
		{
			if( !reference )
			{
				throw new Error("reference==null");
			}
			
			this.offerReference = reference;
			
			if( features )
			{
				this.features = features;
			}
			
			if( resources )
			{
				this.resources = resources;
			}
			
			if( bundleReferences )
			{
				this.bundleReferences = bundleReferences;
			}
			
			if( additionalParameters )
			{
				this.offerAdditionalParameters = additionalParameters;
			}
		}
		
		// ------------------------------------>
		
		/**
		 * Get the reference of the offer
		 * 
		 * @return
		 */
		public function getOfferReference():String
		{
			return offerReference;
		}
		
		/**
		 * Get additional parameters of this offer
		 * 
		 * @return
		 */
		public function getOfferAdditionalParameters():Dictionary
		{
			return offerAdditionalParameters;
		}
		
		// ------------------------------------>
		
		/**
		 * Does this offer contain one or more bundles
		 * 
		 * @return
		 */
		public function hasBundles():Boolean
		{
			return bundleReferences.length > 0;
		}
		
		/**
		 * Get a list of references of bundles this offer contains
		 * 
		 * @return a list of bundles
		 */
		public function getBundleReferences():Vector.<String>
		{
			return bundleReferences;
		}
		
		/**
		 * Does this offer contain at least one feature
		 * 
		 * @return
		 */
		public function hasFeatures():Boolean
		{
			return features.length > 0;
		}
		
		/**
		 * Does this offer contain the given feature
		 * 
		 * @param featureReference reference of the feature
		 * @return
		 */
		public function containsFeature(featureReference:String):Boolean
		{
			return features[featureReference] != null;
		}
		
		/**
		 * Get features you have to provide to the user
		 * 
		 * @return a list of features
		 */
		public function getFeatures():Vector.<Feature>
		{
			return features;
		}
		
		/**
		 * Does this offer contain at least one resource
		 * 
		 * @return
		 */
		public function hasResources():Boolean
		{
			return resources.length > 0;
		}
		
		/**
		 * Does this offer contain the given resource
		 * 
		 * @param resourceReference reference of the resource
		 * @return
		 */
		public function containsResource(resourceReference:String):Boolean
		{
			return resources[resourceReference] != null;
		}
		
		/**
		 * Get resources you have to provide to the user
		 * 
		 * @return a list of resources
		 */
		public function getResources():Vector.<Resource>
		{
			return resources;
		}
		
		// ------------------------------------->
		
		/**
		 * Get a list of aggregated features and resources
		 * 
		 * @return
		 */
		public function getItems():Vector.<Item>
		{
			return features.concat(resources);
		}
		
		/**
		 * Does this offer contain a resource or a feature with this reference
		 * 
		 * @param itemReference
		 * @return
		 */
		public function containsItem(itemReference:String):Boolean
		{
			var containFeature:Boolean = containsFeature(itemReference);
			if( itemReference )
			{
				return true;
			}
			
			return containsResource(itemReference);
		}
	}
}