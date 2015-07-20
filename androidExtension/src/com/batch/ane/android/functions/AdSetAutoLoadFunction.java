package com.batch.ane.android.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.ane.android.Extension;

/**
 * Function called to set ad auto load mode
 * 
 * @author Batch SDK © 2015
 */
public class AdSetAutoLoadFunction implements FREFunction
{

	@Override
	public FREObject call(FREContext ctx, FREObject[] args)
	{
		/*
		 * Retrieve value
		 */
		boolean autoLoad = false;
		
		try
		{
			FREObject obj = args[0];
			autoLoad = obj.getAsBool();
		}
		catch(Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on retrieving value", e);
			return null;
		}
		
		/*
		 * Call SDK
		 */
		Batch.Ads.setAutoLoad(autoLoad);
		
		return null;
	}

}
