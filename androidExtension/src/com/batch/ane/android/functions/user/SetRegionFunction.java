package com.batch.ane.android.functions.user;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.android.BatchUserProfile;
import com.batch.ane.android.Extension;

/**
 * Function called to set custom region
 * 
 * @author Batch SDK © 2015
 */
public class SetRegionFunction implements FREFunction
{

	@Override
	public FREObject call(FREContext ctx, FREObject[] args)
	{
		try
		{
			/*
			 * Retrieve region
			 */
			String region = null;
			
			try
			{
				FREObject obj = args[0];
				if( obj != null )
				{
					region = obj.getAsString();
				}
			}
			catch(Exception e)
			{
				Log.e(Extension.LOG_TAG, "Error on retrieving region", e);
				return FREObject.newObject(false);
			}
			
			/*
			 * Call SDK
			 */
			BatchUserProfile user = Batch.getUserProfile();
			if( user != null )
			{
				user.setRegion(region);
				return FREObject.newObject(true);
			}
			else
			{
				return FREObject.newObject(false);
			}
		}
		catch(Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on SetRegionFunction", e);
			return null;
		}
	}

}
