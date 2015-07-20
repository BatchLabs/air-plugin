package com.batch.ane.android.functions.user;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.android.BatchUserProfile;
import com.batch.ane.android.Extension;

/**
 * Function called to get custom id
 * 
 * @author Batch SDK © 2015
 */
public class GetCustomIDFunction implements FREFunction
{

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1)
	{
		try
		{
			BatchUserProfile user = Batch.getUserProfile();
			if( user != null )
			{
				return FREObject.newObject(user.getCustomID());
			}
			else
			{
				return null;
			}
		}
		catch(Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on GetCustomIDFunction", e);
			return null;
		}
	}

}
