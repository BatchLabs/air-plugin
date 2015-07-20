package com.batch.ane.android.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.AdDisplayListener;
import com.batch.android.Batch;
import com.batch.ane.android.Extension;

/**
 * Function called to display an ad with listener events
 * 
 * @author Batch SDK © 2015
 */
public class AdDisplayWithListenerFunction implements FREFunction
{

	@Override
	public FREObject call(final FREContext ctx, final FREObject[] args)
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
		Batch.Ads.displayInterstitial(ctx.getActivity(), placement, new AdDisplayListener()
		{
			@Override
			public void onNoAdDisplayed()
			{
				ctx.dispatchStatusEventAsync("", "AdOnNoAdDisplayed");
			}
			
			@Override
			public void onAdDisplayed()
			{
				ctx.dispatchStatusEventAsync("", "AdOnAdDisplayed");
			}
			
			@Override
			public void onAdClosed()
			{
				ctx.dispatchStatusEventAsync("", "AdOnAdClosed");			
			}
			
			@Override
			public void onAdClicked()
			{
				ctx.dispatchStatusEventAsync("", "AdOnAdClicked");			
			}
			
			@Override
			public void onAdCancelled()
			{
				ctx.dispatchStatusEventAsync("", "AdOnAdCancelled");			
			}
		});
		
		return null;
	}

}
