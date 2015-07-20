package com.batch.ane.android.helpers;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.batch.android.Application;
import com.batch.android.CodeErrorInfo;
import com.batch.android.Config;
import com.batch.android.Feature;
import com.batch.android.Offer;
import com.batch.android.Resource;

/**
 * Helper to serialize Batch object to JSON and from JSON
 * 
 * @author Batch SDK © 2015
 */
public class JSONMapper
{
	/**
	 * Serialize an Offer to JSON
	 * 
	 * @param offer
	 * @return
	 * @throws JSONException
	 */
	public static JSONObject toJSON(Offer offer) throws JSONException
	{
		if( offer == null )
		{
			throw new NullPointerException("offer==null");
		}
		
		JSONObject json = new JSONObject();
		
		json.put("r", offer.getOfferReference());
		json.put("data", additionalParametersToJSON(offer.getOfferAdditionalParameters()));
		json.put("feat", featuresToJSON(offer.getFeatures()));
		json.put("res", resourcesToJSON(offer.getResources()));
		json.put("bundles", new JSONArray(offer.getBundleReferences()));
		
		return json;
	}
	
	/**
	 * Serialize CodeErrorInfo to JSON
	 * 
	 * @param infos
	 * @return
	 * @throws JSONException
	 */
	public static JSONObject toJSON(CodeErrorInfo infos) throws JSONException
	{
		if( infos == null )
		{
			throw new NullPointerException("infos==null");
		}
		
		JSONObject json = new JSONObject();
		
		json.put("type", infos.getType().toString());
		
		if( infos.hasMissingApplications() )
		{
			json.put("missingApps", missingAppsToJSON(infos.getMissingApplications()));
		}
		
		return json;
	}
	
	/**
	 * Build a Config object from JSON
	 * 
	 * @param configJsonString
	 * @return
	 * @throws JSONException
	 */
	public static Config configFromJSON(String configJsonString) throws JSONException
	{
		if( configJsonString == null )
		{
			throw new NullPointerException("configJsonString==null");
		}
		
		JSONObject configJson = new JSONObject(configJsonString);
		
		String apikey = configJson.getString("androidApikey");
		boolean shouldUseAndroidID = configJson.getBoolean("shouldUseAndroidID");
		boolean shoudlUseAdvertisingID = configJson.getBoolean("shoudlUseAdvertisingID");
		
		return new Config(apikey).setCanUseAdvertisingID(shoudlUseAdvertisingID).setCanUseAndroidID(shouldUseAndroidID);
	}
	
// ------------------------------------------>
	
	/**
	 * Serialize an array of Application to JSON
	 * 
	 * @param missingApplications
	 * @return
	 * @throws JSONException
	 */
	private static JSONArray missingAppsToJSON(List<Application> missingApplications) throws JSONException
	{
		if( missingApplications == null )
		{
			throw new NullPointerException("missingApplications==null");
		}
		
		JSONArray json = new JSONArray();
		
		for( Application app : missingApplications )
		{
			json.put(missingAppToJSON(app));
		}
		
		return json;
	}
	
	/**
	 * Serialize an Application to JSON
	 * 
	 * @param app
	 * @return
	 * @throws JSONException
	 */
	private static JSONObject missingAppToJSON(Application app) throws JSONException
	{
		if( app == null )
		{
			throw new NullPointerException("app==null");
		}
		
		JSONObject json = new JSONObject();
		
		if( app.hasBundleId() )
		{
			json.put("bundleId", app.getBundleId());
		}
		
		if( app.hasScheme() )
		{
			json.put("scheme", app.getScheme());
		}
		
		return json;
	}

	
// ------------------------------------------>

	/**
	 * Serialize an array of Resource to JSON
	 * 
	 * @param resources
	 * @return
	 * @throws JSONException
	 */
	public static JSONArray resourcesToJSON(List<Resource> resources) throws JSONException
	{
		if( resources == null )
		{
			throw new NullPointerException("resources == null");
		}
		
		JSONArray array = new JSONArray();
		
		for(Resource res : resources)
		{
			array.put(resourceToJSON(res));
		}
		
		return array;
	}
	
	/**
	 * Serialize a Resource to JSON
	 * 
	 * @param resource
	 * @return
	 * @throws JSONException
	 */
	private static JSONObject resourceToJSON(Resource resource) throws JSONException
	{
		if( resource == null )
		{
			throw new NullPointerException("resource==null");
		}
		
		JSONObject json = new JSONObject();
		
		json.put("r", resource.getReference());
		json.put("q", resource.getQuantity());
		
		if( resource.isInBundle() )
		{
			json.put("b", resource.getBundleReference());
		}
		
		return json;
	}

	/**
	 * Serialize an array of Feature to JSON
	 * 
	 * @param features
	 * @return
	 * @throws JSONException
	 */
	public static JSONArray featuresToJSON(List<Feature> features) throws JSONException
	{
		if( features == null )
		{
			throw new NullPointerException("features == null");
		}
		
		JSONArray array = new JSONArray();
		
		for(Feature feature : features)
		{
			array.put(featureToJSON(feature));
		}
		
		return array;
	}
	
	/**
	 * Serialize a Feature to JSON
	 * 
	 * @param feature
	 * @return
	 * @throws JSONException
	 */
	private static JSONObject featureToJSON(Feature feature) throws JSONException
	{
		if( feature == null )
		{
			throw new NullPointerException("feature == null");
		}
		
		JSONObject json = new JSONObject();
		
		json.put("r", feature.getReference());
		
		if( feature.isInBundle() )
		{
			json.put("b", feature.getBundleReference());
		}
		
		if( feature.hasValue() )
		{
			json.put("val", feature.getValue());
		}
		
		if( !feature.isLifetime() )
		{
			json.put("ttl", feature.getTTL());
		}
				
		return json;
	}
	
	/**
	 * Serialize additional parameters (Map) to JSON
	 * 
	 * @param parameters
	 * @return
	 * @throws JSONException
	 */
	private static JSONArray additionalParametersToJSON(Map<String, String> parameters) throws JSONException
	{
		if( parameters == null )
		{
			throw new NullPointerException("parameters==null");
		}
		
		JSONArray array = new JSONArray();
		
		for(String n : parameters.keySet())
		{
			JSONObject param = new JSONObject();
			
			param.put("n", n);
			param.put("v", parameters.get(n));
			
			array.put(param);
		}
		
		return array;
	}
}
