package com.adobe.air;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import android.content.res.Configuration;
import android.util.Log;

import com.adobe.air.AndroidActivityWrapper.ActivityState;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.batch.android.Batch;
import com.batch.android.BatchURLListener;
import com.batch.android.BatchUnlockListener;
import com.batch.android.CodeErrorInfo;
import com.batch.android.FailReason;
import com.batch.android.Offer;
import com.batch.ane.android.Extension;
import com.batch.ane.android.functions.AdDisplayFunction;
import com.batch.ane.android.functions.AdDisplayWithListenerFunction;
import com.batch.ane.android.functions.AdHasInterstitialReadyFunction;
import com.batch.ane.android.functions.AdInterstitialLoadFunction;
import com.batch.ane.android.functions.AdSetAutoLoadFunction;
import com.batch.ane.android.functions.CreateFunction;
import com.batch.ane.android.functions.DismissNotificationsFunction;
import com.batch.ane.android.functions.NotImplementedFunction;
import com.batch.ane.android.functions.RedeemCodeFunction;
import com.batch.ane.android.functions.RestoreFunction;
import com.batch.ane.android.functions.SetAndroidNotificationTypesFunction;
import com.batch.ane.android.functions.SetGCMSenderIdFunction;
import com.batch.ane.android.functions.user.GetCustomIDFunction;
import com.batch.ane.android.functions.user.GetLanguageFunction;
import com.batch.ane.android.functions.user.GetRegionFunction;
import com.batch.ane.android.functions.user.SetCustomIDFunction;
import com.batch.ane.android.functions.user.SetLanguageFunction;
import com.batch.ane.android.functions.user.SetRegionFunction;
import com.batch.ane.android.helpers.JSONMapper;

/**
 * Extension context that register to lifecycle events, functions of the wrapper and Unlock auto & url listeners
 * 
 * @author Batch SDK © 2015
 */
public class ExtensionContext extends FREContext implements AndroidActivityWrapper.StateChangeCallback, BatchUnlockListener, BatchURLListener
{
	/**
	 * Constructor
	 */
	public ExtensionContext() 
	{  
		// Register to lifecycle events
		AndroidActivityWrapper.GetAndroidActivityWrapper().addActivityStateChangeListner(this);
	}
	
// ----------------------------------------->

	@Override
	public void dispose()
	{
		// Unregister listener
		AndroidActivityWrapper.GetAndroidActivityWrapper().removeActivityStateChangeListner(this);
	}

	@Override
	public Map<String, FREFunction> getFunctions()
	{
		Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
		
		functions.put("create", 							new CreateFunction());
		
		// Unlock
		functions.put("redeemCode", 						new RedeemCodeFunction());
		functions.put("restore", 							new RestoreFunction());
		functions.put("onSchemeFound", 						new NotImplementedFunction());
		
		// Push
		functions.put("setGCMSenderId", 					new SetGCMSenderIdFunction());
		functions.put("dismissNotifications", 				new DismissNotificationsFunction());
		functions.put("clearBadge", 						new NotImplementedFunction());
		functions.put("registerForRemoteNotifications", 	new NotImplementedFunction());
		functions.put("setiOSNotificationTypes", 			new NotImplementedFunction());
		functions.put("setAndroidNotificationTypes", 		new SetAndroidNotificationTypesFunction());
		
		// User
		functions.put("setUserCustomID", 					new SetCustomIDFunction());
		functions.put("getUserCustomID", 					new GetCustomIDFunction());
		functions.put("setUserLanguage", 					new SetLanguageFunction());
		functions.put("getUserLanguage", 					new GetLanguageFunction());
		functions.put("setUserRegion", 						new SetRegionFunction());
		functions.put("getUserRegion", 						new GetRegionFunction());
		
		// Ads
		functions.put("adDisplay",							new AdDisplayFunction());
		functions.put("adDisplayWithListener", 				new AdDisplayWithListenerFunction());
		functions.put("adHasInterstitialReady",				new AdHasInterstitialReadyFunction());
		functions.put("adSetAutoLoad", 						new AdSetAutoLoadFunction());
		functions.put("adLoadForPlacement",					new AdInterstitialLoadFunction());
		functions.put("adSetup", 							new NotImplementedFunction());
		
		return functions;
	}

	@Override
	public void onActivityStateChanged(ActivityState state)
	{
		switch (state)
		{
			case RESTARTED:
			{
				Batch.Unlock.setUnlockListener(this);
				Batch.Unlock.setURLListener(this);
				
				Batch.onStart(getActivity());
				break;
			}
			case STOPPED:
			{
				Batch.onStop(getActivity());
				break;
			}	
			case DESTROYED:
			{
				Batch.onDestroy(getActivity());
				break;
			}
			default:
				break;
		}
	}

	@Override
	public void onConfigurationChanged(Configuration config)
	{
		// Nothing specific to be done for Batch
	}

	@Override
	public void onURLWithCodeFound(String code)
	{
		dispatchStatusEventAsync(code, "onURLWithCodeFound");
	}
	
	@Override
	public void onURLCodeSuccess(String code, Offer offer)
	{
		try
		{
			JSONObject response = new JSONObject();
			response.put("code", code);
			response.put("offer", JSONMapper.toJSON(offer));
			
			dispatchStatusEventAsync(response.toString(), "onURLCodeSuccess");
		}
		catch (Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on onURLCodeSuccess callback", e);
		}
	}
	
	@Override
	public void onURLCodeFailed(String code, FailReason reason, CodeErrorInfo infos)
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
			
			dispatchStatusEventAsync(response.toString(), "onURLCodeFailed");
		}
		catch (Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on onURLCodeFailed callback", e);
		}
	}

	@Override
	public void onRedeemAutomaticOffer(Offer offer)
	{
		try
		{
			String offerJson = JSONMapper.toJSON(offer).toString();
			
			dispatchStatusEventAsync(offerJson, "onRedeemOffer");
		}
		catch (Exception e)
		{
			Log.e(Extension.LOG_TAG, "Error on onRedeemAutomaticOffer callback", e);
		}
	}

}
