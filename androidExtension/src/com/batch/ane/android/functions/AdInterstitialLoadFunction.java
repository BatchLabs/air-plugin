package com.batch.ane.android.functions;

import org.json.JSONObject;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.android.BatchAdsError;
import com.batch.android.BatchInterstitialListener;
import com.batch.ane.android.Extension;

/**
 * Function called to get load interstitial
 * 
 * @author Batch SDK © 2015
 */
public class AdInterstitialLoadFunction implements FREFunction
{

	@Override
	public FREObject call(final FREContext ctx, FREObject[] args)
	{
		/*
		 * Retrieve placement
		 */
		String placement = null;
		
		try
		{
			FREObject obj = args[0];
			if( obj != null )
			{
				placement = obj.getAsString();
			}
		}
		catch(Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on retrieving placement", e);
			return null;
		}
		
		/*
		 * Call SDK
		 */
		Batch.Ads.loadInterstitial(placement, new BatchInterstitialListener()
		{
			
			@Override
			public void onInterstitialReady(String placementReference)
			{
				ctx.dispatchStatusEventAsync(placementReference, "onAdAvailableForPlacement");
			}
			
			@Override
			public void onFailedToLoadInterstitial(String placementReference, BatchAdsError error)
			{
				try
				{
					JSONObject obj = new JSONObject();
					obj.put("placement", placementReference);
					obj.put("error", error.toString());
					
					ctx.dispatchStatusEventAsync(obj.toString(), "onFailToLoadAdForPlacement");
				}
				catch(Exception e)
				{
					Log.e(Extension.LOG_TAG, "Error on onFailedToLoadInterstitial", e);
				}
			}
		});
		
		return null;
	}

}
