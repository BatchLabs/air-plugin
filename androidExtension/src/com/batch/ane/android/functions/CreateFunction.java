package com.batch.ane.android.functions;

import android.util.Log;

import com.adobe.air.ExtensionContext;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.android.Config;
import com.batch.ane.android.Extension;
import com.batch.ane.android.helpers.JSONMapper;

/**
 * Function called to set-up SDK
 * 
 * @author Batch SDK © 2015
 */
public class CreateFunction implements FREFunction
{

	@Override
	public FREObject call(final FREContext context, FREObject[] args)
	{	
		/*
		 * Retrieve config
		 */
		Config config = null;
		
		try
		{
			String configJson = args[0].getAsString();
			config = JSONMapper.configFromJSON(configJson);
		}
		catch(Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on retrieving Batch config", e);
			return null;
		}
		
		/*
		 * Get context
		 */
		ExtensionContext extensionContext = (ExtensionContext) context;
		
		/*
		 * Set-up and start SDK
		 */
		Batch.setConfig(config);
		
		Batch.Unlock.setUnlockListener(extensionContext);
		Batch.Unlock.setURLListener(extensionContext);
		
		Batch.onStart(context.getActivity());
		
		return null;
	}

}
