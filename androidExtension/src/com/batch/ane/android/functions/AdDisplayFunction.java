package com.batch.ane.android.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.ane.android.Extension;

/**
 * Function called to display an ad
 * 
 * @author Batch SDK © 2015
 */
public class AdDisplayFunction implements FREFunction
{

	@Override
	public FREObject call(FREContext ctx, FREObject[] args)
	{
		try
		{
			/*
			 * Get placement
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
			return FREObject.newObject(Batch.Ads.displayInterstitial(ctx.getActivity(), placement));
		}
		catch(Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on AdDisplayFunction", e);
			return null;
		}
	}

}
