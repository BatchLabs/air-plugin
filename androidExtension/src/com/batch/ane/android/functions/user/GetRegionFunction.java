package com.batch.ane.android.functions.user;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.android.BatchUserProfile;
import com.batch.ane.android.Extension;

/**
 * Function called to get custom region
 * 
 * @author Batch SDK © 2015
 */
public class GetRegionFunction implements FREFunction
{

	@Override
	public FREObject call(FREContext ctx, FREObject[] args)
	{
		try
		{
			BatchUserProfile user = Batch.getUserProfile();
			if( user != null )
			{
				return FREObject.newObject(user.getRegion());
			}
			else
			{
				return null;
			}
		}
		catch(Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on GetRegionFunction", e);
			return null;
		}
	}

}
