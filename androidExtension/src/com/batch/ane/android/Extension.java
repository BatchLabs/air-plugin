package com.batch.ane.android;

import com.adobe.air.ExtensionContext;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/**
 * Batch extension
 * 
 * @author Batch SDK © 2015
 */
public class Extension implements FREExtension
{
	/**
	 * Version of the plugin
	 */
	private static final String PLUGIN_VERSION = "1.4";
	
	/**
	 * Log tag for error logs of this extension
	 */
	public static final String LOG_TAG = "BatchANE";
	
// ---------------------------------------------->

	@Override
	public FREContext createContext(String contextType)
	{
		return new ExtensionContext();
	}

	@Override
	public void dispose()
	{
		// Nothing to do here
	}

	@Override
	public void initialize()
	{
		// Set plugin version, read by the SDK
		System.setProperty("batch.plugin.version", "Air/"+PLUGIN_VERSION);
	}

}
