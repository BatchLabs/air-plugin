package com.batch.ane.android.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.android.PushNotificationType;
import com.batch.ane.android.Extension;

/**
 * Function called to set notification types for Android
 * 
 * @author Batch SDK © 2015
 */
public class SetAndroidNotificationTypesFunction implements FREFunction
{

	@Override
	public FREObject call(FREContext ctx, FREObject[] args)
	{
		/*
		 * Retrieve notif type
		 */
		int notifType = 0;
		try
		{
			notifType = args[0].getAsInt();
		}
		catch(Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on retrieving notif type", e);
			return null;
		}
		
		Batch.Push.setNotificationsType(PushNotificationType.fromValue(notifType));
		return null;
	}

}
