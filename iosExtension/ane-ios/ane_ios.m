#import "FlashRuntimeExtensions.h"
#import "Config.h"
#import <Batch/Batch.h>
#import <Batch/BatchUnlock.h>
#import <Batch/BatchOffer.h>
#import <Batch/BatchError.h>
#import <Batch/BatchPush.h>
#import <Batch/BatchAds.h>
#import <Batch/BatchUserProfile.h>
#import "BAESerializationHelper.h"
#import <UIKit/UIKit.h>
#import "BAUnlockDelegate.h"
#import "BAAdDisplayDelegate.h"

// Staticly saved config
Config *_config = NULL;
// Staticaly retained delegate (to avoid ARC to kill it)
BAUnlockDelegate *_delegate;

const NSString *pluginVersion = @"1.3.2";

// Function called to set-up SDK
FREObject create(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    // Retrieve config
    const uint8_t *configjson;
    uint32_t configjsonlenght;
    FREGetObjectAsUTF8(argv[0], &configjsonlenght, &configjson);
    
    _config = [BAESerializationHelper configFromJSON:[NSString stringWithUTF8String:(char *)configjson]];
    
    // Start SDK
    [Batch setUseIDFA:[_config canUseIDFA]];
    
    _delegate = [[BAUnlockDelegate alloc] initWithContext:ctx];
    [BatchUnlock setupUnlockWithDelegate:_delegate];
    
    [Batch startWithAPIKey:[_config apikey]];
    
    return NULL;
}

// Function called to redeem a promocode
FREObject redeemCode(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    // Save context
    __block FREContext redeemContext = ctx;
    
    // Retrieve code
    const uint8_t *code = NULL;
    uint32_t codelength;
    FREGetObjectAsUTF8(argv[0], &codelength, &code);
    
    NSString *redeemCode = [NSString stringWithUTF8String:(char *)code];
    
    // Call SDK
    [BatchUnlock redeemCode:redeemCode success:^(id<BatchOffer> offer)
     {
         NSMutableDictionary *resp = [[NSMutableDictionary alloc] init];
         
         [resp setObject:redeemCode forKey:@"code"];
         [resp setObject:[BAESerializationHelper offerToDictionnary:offer] forKey:@"offer"];
         
         const uint8_t* eventCode = (const uint8_t*) [[BAESerializationHelper dictionnaryToJSON:resp] UTF8String];
         const uint8_t* eventLevel = (const uint8_t*) [@"onRedeemCodeSuccess" UTF8String];
         
         FREDispatchStatusEventAsync(redeemContext, eventCode, eventLevel);
         
     } failure:^(BatchError *error)
     {
         NSMutableDictionary *resp = [[NSMutableDictionary alloc] init];
         
         [resp setObject:redeemCode forKey:@"code"];
         [resp setObject:[BAESerializationHelper reasonToString:error] forKey:@"reason"];
         
         if( [BAESerializationHelper shouldAddCodeErrorInfos:error] )
         {
             [resp setObject:[BAESerializationHelper codeErrorInfosToDictionnary:error] forKey:@"infos"];
         }
         
         
         const uint8_t* eventCode = (const uint8_t*) [[BAESerializationHelper dictionnaryToJSON:resp] UTF8String];
         const uint8_t* eventLevel = (const uint8_t*) [@"onRedeemCodeFailed" UTF8String];
         
         FREDispatchStatusEventAsync(redeemContext, eventCode, eventLevel);
         
     }];
    
    return NULL;
}

// Function called to redeem a restore unlocks
FREObject restore(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    // Save context
    __block FREContext restoreContext = ctx;
    
    // Call SDK
    [BatchUnlock restoreFeatures:^(NSArray *features)
    {
        NSDictionary *resp = @{@"feat": [BAESerializationHelper featuresToArray:features]};
        
        const uint8_t* eventCode = (const uint8_t*) [[BAESerializationHelper dictionnaryToJSON:resp] UTF8String];
        const uint8_t* eventLevel = (const uint8_t*) [@"onRestoreSucceed" UTF8String];
        
        FREDispatchStatusEventAsync(restoreContext, eventCode, eventLevel);
        
    } failure:^(BatchError *error)
    {
        const uint8_t* eventCode = (const uint8_t*) [[BAESerializationHelper reasonToString:error] UTF8String];
        const uint8_t* eventLevel = (const uint8_t*) [@"onRestoreFailed" UTF8String];
        
        FREDispatchStatusEventAsync(restoreContext, eventCode, eventLevel);
        
    }];
    
    return NULL;
}

// Function called when a scheme has been found (app open via deeplink)
FREObject onSchemeFound(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    // Retrieve url
    const uint8_t *url = NULL;
    uint32_t urllength;
    FREGetObjectAsUTF8(argv[0], &urllength, &url);
    
    NSString *urlScheme = [NSString stringWithUTF8String:(char *)url];
    
    // Call SDK
    bool ok = [Batch handleURL:[NSURL URLWithString:urlScheme]];
    if( !ok ){} // Just to avoid xcode warning

    return NULL;
}

// Stub function that does nothing. Used for Android only functions
FREObject notImplementedFunction(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

// Function called to dismiss push notifications
FREObject dismissNotifications(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    [BatchPush dismissNotifications];
    return NULL;
}

// Function called to clear badges (from notifications)
FREObject clearBadge(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    [BatchPush clearBadge];
    return NULL;
}

// Function called to subscribe to push notifications (will trigger the popup the first time its called)
FREObject registerForRemoteNotifications(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    [BatchPush registerForRemoteNotifications];
    return NULL;
}

// Function called to set notification types for iOS
FREObject setRemoteNotificationTypes(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    // Retrieve notif type
    uint32_t notifType;
    FREGetObjectAsUint32(argv[0], &notifType);
    
    // Call SDK
    [BatchPush setRemoteNotificationTypes:(NSUInteger)notifType];
    return NULL;
}

#pragma mark User

// Function called to set custom id
FREObject setUserCustomID(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject returnValue;
    
    @try
    {
        // Retrieve custom ID
        const uint8_t *customID = NULL;
        uint32_t customIDLenght;
        FREGetObjectAsUTF8(argv[0], &customIDLenght, &customID);
        
        // Call SDK
        [Batch defaultUserProfile].customIdentifier = customID ? [NSString stringWithUTF8String:(char *)customID] : nil;
        
        FRENewObjectFromBool(1, &returnValue);
    }
    @catch (NSException *exception)
    {
        FRENewObjectFromBool(0, &returnValue);
    }
    
    return returnValue;
}

// Function called to get custom id
FREObject getUserCustomID(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    @try
    {
        NSString *customID = [Batch defaultUserProfile].customIdentifier;
        
        FREObject returnValue;
        FRENewObjectFromUTF8((uint32_t)[customID length], (uint8_t*)[customID UTF8String], &returnValue);
        return returnValue;
    }
    @catch (NSException *exception)
    {
        return NULL;
    }
}

// Function called to set custom language
FREObject setUserLanguage(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject returnValue;
    
    @try
    {
        // Retrieve language
        const uint8_t *language = NULL;
        uint32_t languageLenght;
        FREGetObjectAsUTF8(argv[0], &languageLenght, &language);
        
        // Call SDK
        [Batch defaultUserProfile].language = language ? [NSString stringWithUTF8String:(char *)language] : nil;
        
        FRENewObjectFromBool(1, &returnValue);
    }
    @catch (NSException *exception)
    {
        FRENewObjectFromBool(0, &returnValue);
    }
    
    return returnValue;
}

// Function called to get custom language
FREObject getUserLanguage(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    @try
    {
        NSString *language = [Batch defaultUserProfile].language;
        
        FREObject returnValue;
        FRENewObjectFromUTF8((uint32_t)[language length], (uint8_t*)[language UTF8String], &returnValue);
        return returnValue;
    }
    @catch (NSException *exception)
    {
        return NULL;
    }
}

// Function called to set custom region
FREObject setUserRegion(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject returnValue;
    
    @try
    {
        // Retrieve region
        const uint8_t *region = NULL;
        uint32_t regionLenght;
        FREGetObjectAsUTF8(argv[0], &regionLenght, &region);
        
        // Call SDK
        [Batch defaultUserProfile].region = region ? [NSString stringWithUTF8String:(char *)region] : nil;
        
        FRENewObjectFromBool(1, &returnValue);
    }
    @catch (NSException *exception)
    {
        FRENewObjectFromBool(0, &returnValue);
    }
    
    return returnValue;
}

// Function called to get custom region
FREObject getUserRegion(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    @try
    {
        NSString *region = [Batch defaultUserProfile].region;
        
        FREObject returnValue;
        FRENewObjectFromUTF8((uint32_t)[region length], (uint8_t*)[region UTF8String], &returnValue);
        return returnValue;
    }
    @catch (NSException *exception)
    {
        return NULL;
    }
}

#pragma mark Ads

// Function called to set-up ads
FREObject adSetup(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    [BatchAds setupAds];
    
    return NULL;
}

// Function called to display an ad
FREObject adDisplay(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    // Retrieve placement
    const uint8_t *placementutf = NULL;
    uint32_t placementlength;
    FREGetObjectAsUTF8(argv[0], &placementlength, &placementutf);
    
    NSString *placementStr = [NSString stringWithUTF8String:(char *)placementutf];
    
    // Call SDK
    BOOL displayed = [BatchAds displayInterstitialForPlacement:placementStr];
    
    FREObject returnValue;
    FRENewObjectFromBool(displayed, returnValue);
    
    return returnValue;
}

// Function called to display an ad with listener
FREObject adDisplayWithListener(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    const uint8_t *placementutf = NULL;
    uint32_t placementlength;
    FREGetObjectAsUTF8(argv[0], &placementlength, &placementutf);
    
    NSString *placementStr = [NSString stringWithUTF8String:(char *)placementutf];
    
    [BatchAds displayInterstitialForPlacement:placementStr withDelegate:[BAAdDisplayDelegate createNewDelegateWithContext:ctx]];

    return NULL;
}

// Function called to get intersitial loading status
FREObject adHasAdReadyForPlacement(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    // Retrieve placement
    const uint8_t *placementutf = NULL;
    uint32_t placementlength;
    FREGetObjectAsUTF8(argv[0], &placementlength, &placementutf);
    
    NSString *placementStr = [NSString stringWithUTF8String:(char *)placementutf];
    
    // Call SDK
    BOOL hasAd = [BatchAds hasInterstitialForPlacement:placementStr];
    
    FREObject returnValue;
    FRENewObjectFromBool(hasAd, returnValue);
    
    return returnValue;
}

// Function called to set ad auto load mode
FREObject adSetAutoLoad(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    // Retrieve value
    uint32_t boolean;
    FREGetObjectAsBool(argv[0], &boolean);
    
    // Call SDK
    [BatchAds setAutoLoad:boolean];
    
    return NULL;
}

// Function called to get load interstitial
FREObject adLoad(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    __block FREContext adsContext = ctx;

    const uint8_t *placementutf = NULL;
    uint32_t placementlength;
    FREGetObjectAsUTF8(argv[0], &placementlength, &placementutf);
    
    NSString *placementStr = [NSString stringWithUTF8String:(char *)placementutf];
    
    [BatchAds loadInterstitialForPlacement:placementStr completion:^(NSString *placement, BatchError *error){
        if( error != nil )
        {
            NSDictionary *resp = @{@"placement": placementStr, @"error" : [BAESerializationHelper reasonToString:error]};
            
            const uint8_t* eventCode = (const uint8_t*) [[BAESerializationHelper dictionnaryToJSON:resp] UTF8String];
            const uint8_t* eventLevel = (const uint8_t*) [@"onFailToLoadAdForPlacement" UTF8String];
            
            FREDispatchStatusEventAsync(adsContext, eventCode, eventLevel);
        }
        else
        {
            const uint8_t* eventCode = (const uint8_t*) [placementStr UTF8String];
            const uint8_t* eventLevel = (const uint8_t*) [@"onAdAvailableForPlacement" UTF8String];
            
            FREDispatchStatusEventAsync(adsContext, eventCode, eventLevel);
        }
    }];
    
    return NULL;
}


#pragma mark -

void BatchExtensionContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    *numFunctionsToTest = 22;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * *numFunctionsToTest);
    
    func[0].name = (const uint8_t*) "create";
    func[0].functionData = NULL;
    func[0].function = &create;
    
    // Unlock
    func[1].name = (const uint8_t*) "redeemCode";
    func[1].functionData = NULL;
    func[1].function = &redeemCode;
    
    func[2].name = (const uint8_t*) "restore";
    func[2].functionData = NULL;
    func[2].function = &restore;
    
    func[3].name = (const uint8_t*) "onSchemeFound";
    func[3].functionData = NULL;
    func[3].function = &onSchemeFound;
    
    // Push
    func[4].name = (const uint8_t*) "setGCMSenderId";
    func[4].functionData = NULL;
    func[4].function = &notImplementedFunction;

    func[5].name = (const uint8_t*) "dismissNotifications";
    func[5].functionData = NULL;
    func[5].function = &dismissNotifications;
    
    func[6].name = (const uint8_t*) "clearBadge";
    func[6].functionData = NULL;
    func[6].function = &clearBadge;
    
    func[7].name = (const uint8_t*) "registerForRemoteNotifications";
    func[7].functionData = NULL;
    func[7].function = &registerForRemoteNotifications;
    
    func[8].name = (const uint8_t*) "setiOSNotificationTypes";
    func[8].functionData = NULL;
    func[8].function = &setRemoteNotificationTypes;
    
    func[9].name = (const uint8_t*) "setAndroidNotificationTypes";
    func[9].functionData = NULL;
    func[9].function = &notImplementedFunction;
    
    // User
    func[10].name = (const uint8_t*) "setUserCustomID";
    func[10].functionData = NULL;
    func[10].function = &setUserCustomID;
    
    func[11].name = (const uint8_t*) "getUserCustomID";
    func[11].functionData = NULL;
    func[11].function = &getUserCustomID;
    
    func[12].name = (const uint8_t*) "setUserLanguage";
    func[12].functionData = NULL;
    func[12].function = &setUserLanguage;
    
    func[13].name = (const uint8_t*) "getUserLanguage";
    func[13].functionData = NULL;
    func[13].function = &getUserLanguage;
    
    func[14].name = (const uint8_t*) "setUserRegion";
    func[14].functionData = NULL;
    func[14].function = &setUserRegion;
    
    func[15].name = (const uint8_t*) "getUserRegion";
    func[15].functionData = NULL;
    func[15].function = &getUserRegion;
    
    // Ads
    func[16].name = (const uint8_t*) "adSetup";
    func[16].functionData = NULL;
    func[16].function = &adSetup;
    
    func[17].name = (const uint8_t*) "adDisplay";
    func[17].functionData = NULL;
    func[17].function = &adDisplay;
    
    func[18].name = (const uint8_t*) "adDisplayWithListener";
    func[18].functionData = NULL;
    func[18].function = &adDisplayWithListener;
    
    func[19].name = (const uint8_t*) "adHasInterstitialReady";
    func[19].functionData = NULL;
    func[19].function = &adHasAdReadyForPlacement;
    
    func[20].name = (const uint8_t*) "adSetAutoLoad";
    func[20].functionData = NULL;
    func[20].function = &adSetAutoLoad;
    
    func[21].name = (const uint8_t*) "adLoadForPlacement";
    func[21].functionData = NULL;
    func[21].function = &adLoad;
    
    *functionsToSet = func;
}

void BatchExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &BatchExtensionContextInitializer;
    
    // Setup plugin version.
    NSString *infos = [NSString stringWithFormat:@"Air/%@", pluginVersion];
    setenv("BATCH_PLUGIN_VERSION", [infos cStringUsingEncoding:NSUTF8StringEncoding], 1);
}

