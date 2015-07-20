package com.batch.ane.android.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

/**
 * Stub function that does nothing. Used for iOS only functions
 * 
 * @author Batch SDK © 2015
 */
public class NotImplementedFunction implements FREFunction
{

	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		return null;
	}

}
