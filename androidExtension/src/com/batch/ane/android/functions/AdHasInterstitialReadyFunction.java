package com.batch.ane.android.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.ane.android.Extension;

/**
 * Function called to get intersitial loading status
 * 
 * @author Batch SDK © 2015
 */
public class AdHasInterstitialReadyFunction implements FREFunction
{

	@Override
	public FREObject call(FREContext ctx, FREObject[] args)
	{
		try
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
				return FREObject.newObject(false);
			}
			
			/*
			 * Call SDK
			 */
			return FREObject.newObject(Batch.Ads.hasInterstitialReady(placement));
		}
		catch(Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on AdHasInterstitialReadyFunction", e);
			return null;
		}
	}

}
