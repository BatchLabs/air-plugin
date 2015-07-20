package com.batch.ane.android.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.ane.android.Extension;

/**
 * Function called to set GCM sender id
 * 
 * @author Batch SDK © 2015
 */
public class SetGCMSenderIdFunction implements FREFunction
{

	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		/*
		 * Retrieve GCM sender id
		 */
		String gcmSenderId = null;
		
		try
		{
			gcmSenderId = args[0].getAsString();
		}
		catch(Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on retrieving gcm sender id", e);
			return null;
		}
		
		/*
		 * Call SDK
		 */
		Batch.Push.setGCMSenderId(gcmSenderId);
		
		return null;
	}

}
