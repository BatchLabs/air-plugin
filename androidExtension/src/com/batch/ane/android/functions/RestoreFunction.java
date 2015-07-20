package com.batch.ane.android.functions;

import java.util.List;

import org.json.JSONObject;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.android.BatchRestoreListener;
import com.batch.android.FailReason;
import com.batch.android.Feature;
import com.batch.ane.android.Extension;
import com.batch.ane.android.helpers.JSONMapper;

/**
 * Function called to redeem a restore unlocks
 * 
 * @author Batch SDK © 2015
 */
public class RestoreFunction implements FREFunction
{

	@Override
	public FREObject call(final FREContext context, FREObject[] args)
	{
		Batch.Unlock.restore(new BatchRestoreListener()
		{
			
			@Override
			public void onRestoreSucceed(List<Feature> features)
			{
				try
				{
					JSONObject response = new JSONObject();
					
					response.put("feat", JSONMapper.featuresToJSON(features));
					
					context.dispatchStatusEventAsync(response.toString(), "onRestoreSucceed");
				}
				catch(Exception e)
				{
					Log.e(Extension.LOG_TAG, "Error on onRestoreSucceed", e);
				}
			}
			
			@Override
			public void onRestoreFailed(FailReason reason)
			{
				context.dispatchStatusEventAsync(reason.toString(), "onRestoreFailed");
			}
		});
		
		return null;
	}

}
