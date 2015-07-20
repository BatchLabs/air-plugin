package com.batch.ane.android.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;

/**
 * Function called to dismiss push notifications
 * 
 * @author Batch SDK © 2015
 */
public class DismissNotificationsFunction implements FREFunction
{

	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		Batch.Push.dismissNotifications();
		
		return null;
	}

}
