package com.batch.ane
{
	import flash.utils.Dictionary;

	internal class JSONMapper
	{
		internal static function mapOffer(json:Object):Offer
		{
			// Promotion Ref
			var promotionRef:String = json.r;
			
			// Additional data
			var promotionAddionnalData:Dictionary = null;
			if( json.data )
			{
				promotionAddionnalData = readAdditionalData(json.data);
			}
			
			// Features
			var features:Vector.<Feature> = null;
			if( json.feat )
			{
				features = getFeaturesFromArray(json.feat);
			}
			
			// Resources
			var resources:Vector.<Resource> = null;
			if( json.res )
			{
				resources = getResourcesFromArray(json.res);
			}
			
			// Bundles
			var bundles:Vector.<String> = null;
			if( json.bundles )
			{
				bundles = new Vector.<String>();
				
				for(var i:String in json.bundles)
				{
					bundles.push(json.bundles[i]);
				}
			}
			
			return new Offer(promotionRef, features, resources, bundles, promotionAddionnalData);
		}
		
		internal static function mapErrorInfos(json:Object):CodeErrorInfo
		{
			if( !json )
			{
				return null;
			}
			
			return new CodeErrorInfo(json.type, getMissingApps(json.missingApps));
		}
		
		internal static function configToJson(config:Config):String
		{
			if( !config )
			{
				return null;
			}
			
			var json:Object = new Object();
			
			// Set API keys
			if( config.androidApikey )
			{
				json["androidApikey"] 		= config.androidApikey;
			}
			
			if( config.iOSApiKey )
			{
				json["iosApikey"] 			= config.iOSApiKey;
			}
			
			// Set other params
			json["shouldUseAndroidID"] 		= config.shouldUseAndroidID;
			json["shoudlUseAdvertisingID"] 	= config.shouldUseAdvertisingID;
			json["shouldUseIDFA"]			= config.shouldUseIDFA;
			
			return JSON.stringify(json);
		} 
		
		// ---------------------------------------------->
		
		internal static function getMissingApps(array:Array):Vector.<Application>
		{
			if( !array )
			{
				return null;
			}
			
			var apps:Vector.<Application> = new Vector.<Application>();
			
			if( array.length > 0 )
			{
				for each(var obj:Object in array) 
				{
					apps.push(getApplication(obj));
				}
			}
			
			return apps;
		}
		
		internal static function getApplication(json:Object):Application
		{
			if( !json )
			{
				throw new Error("json==null");
			}
			
			return new Application(json.bundleId ? json.bundleId : json.scheme, !json.bundleId);
		}
		
		// ---------------------------------------------->
		
		internal static function readAdditionalData(array:Array):Dictionary
		{
			var data:Dictionary = new Dictionary();
			
			if( array && array.length > 0 )
			{
				for each(var obj:Object in array) 
				{
					data[obj.n] = obj.v;
				}
			}
			
			return data;
		}
		
		public static function getFeaturesFromArray(array:Array):Vector.<Feature>
		{
			var features:Vector.<Feature> = new Vector.<Feature>();
			
			if( array && array.length > 0 )
			{
				for each(var obj:Object in array)
				{
					features.push(getFeatureFromJson(obj));
				}
			}
			
			return features;
		}
		
		internal static function getFeatureFromJson(json:Object):Feature
		{
			var featureRef:String = json.r;
			var value:String = null;
			var ttl:Number = 0;
			var bundleId:String = null;
			
			if( json.val )
			{
				value = json.val;
			}
			
			if( json.ttl )
			{
				ttl = json.ttl;
			}
			
			if( json.b )
			{
				bundleId = json.b;
			}
			
			return new Feature(featureRef, bundleId, value, ttl);
		}
		
		public static function getResourcesFromArray(array:Array):Vector.<Resource>
		{
			var resources:Vector.<Resource> = new Vector.<Resource>();
			
			if( array && array.length > 0 )
			{
				for each(var obj:Object in array)
				{
					resources.push(getResourceFromJson(obj));
				}
			}
			
			return resources;
		}
		
		internal static function getResourceFromJson(json:Object):Resource
		{
			var resId:String = json.r;
			var quantity:Number = json.q;
			var bundleId:String = null;
			
			if( json.b )
			{
				bundleId = json.b;
			}
			
			return new Resource(resId, bundleId, quantity);
		}
	}
}