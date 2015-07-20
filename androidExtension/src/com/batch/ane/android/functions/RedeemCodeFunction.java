package com.batch.ane.android.functions;

import org.json.JSONObject;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.batch.android.Batch;
import com.batch.android.BatchCodeListener;
import com.batch.android.CodeErrorInfo;
import com.batch.android.FailReason;
import com.batch.android.Offer;
import com.batch.ane.android.Extension;
import com.batch.ane.android.helpers.JSONMapper;

/**
 * Function called to redeem a promocode
 * 
 * @author Batch SDK © 2015
 */
public class RedeemCodeFunction implements FREFunction
{

	@Override
	public FREObject call(final FREContext context, FREObject[] args)
	{
		/*
		 * Retrieve code
		 */
		String code = null;
		
		try
		{
			code = args[0].getAsString();
		}
		catch(Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on retrieving code", e);
			return null;
		}
		
		/*
		 * Call SDK
		 */
		Batch.Unlock.redeemCode(code, new BatchCodeListener()
		{
			@Override
			public void onRedeemCodeSuccess(String code, Offer offer)
			{				
				try
				{
					JSONObject response = new JSONObject();
					response.put("code", code);
					response.put("offer", JSONMapper.toJSON(offer));
					
					context.dispatchStatusEventAsync(response.toString(), "onRedeemCodeSuccess");
				}
				catch (Exception e)
				{
					Log.e(Extension.LOG_TAG, "Error on onRedeemCodeSuccess", e);
				}
			}
			
			@Override
			public void onRedeemCodeFailed(String code, FailReason reason, CodeErrorInfo infos)
			{				
				try
				{
					JSONObject response = new JSONObject();
					response.put("code", code);
					response.put("reason", reason.toString());
					
					if( infos != null )
					{
						response.put("infos", JSONMapper.toJSON(infos));
					}
					
					context.dispatchStatusEventAsync(response.toString(), "onRedeemCodeFailed");
				}
				catch (Exception e)
				{
					Log.e(Extension.LOG_TAG, "Error on onRedeemCodeFailed", e);
				}
			}
		});
		
		return null;
	}

}
