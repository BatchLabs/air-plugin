//
//  BAESerializationHelper.m
//  ane-ios
//
//  Created by Benoit Letondor on 29/04/2014.
//  Copyright (c) 2014 BastionSDK. All rights reserved.
//

#import "BAESerializationHelper.h"

@implementation BAESerializationHelper

// Serialize a Config object from JSON
+ (Config *)configFromJSON:(NSString *)json
{
    id jsonObj = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    NSString *apikey = [jsonObj objectForKey:@"iosApikey"];
    BOOL shouldUseIDFA = [[jsonObj objectForKey:@"shouldUseIDFA"] boolValue];
    
    Config *config = [[Config alloc] initWithApiKey:apikey];
    [config setCanUseIDFA:shouldUseIDFA];
    
    return config;
}

// Serialize native dictionnary to JSON
+ (NSString *)dictionnaryToJSON:(NSDictionary *)dictionnary
{
    NSData *serializedData = [NSJSONSerialization dataWithJSONObject:dictionnary options:0 error:nil];
    
    return [[NSString alloc] initWithData:serializedData encoding:NSUTF8StringEncoding];
}

#pragma mark Error

// Get the serialized value of an error
+ (NSString *)reasonToString:(BatchError *)error
{
    switch ( error.code )
    {
        case BatchFailReasonNetworkError:
            return @"NETWORK_ERROR";
        case BatchFailReasonInvalidAPIKey:
            return @"INVALID_API_KEY";
        case BatchFailReasonDeactivatedAPIKey:
            return @"DEACTIVATED_API_KEY";
        case BatchFailReasonInvalidCode:
            return @"INVALID_CODE";
        case BatchFailReasonMismatchConditions:
            return @"MISMATCH_CONDITIONS";
        case BatchFailReasonUnknownPlacement:
            return @"UNKNOWN_PLACEMENT";
        case BatchFailReasonNoAdFound:
            return @"NO_AD_AVAILABLE";
        default:
            return @"UNEXPECTED_ERROR";
    }
}

// Is this error about promocode
+ (BOOL)shouldAddCodeErrorInfos:(BatchError *)error
{
    return [error invalidCodeError] != 0;
}

// Serialize the code error info to JSON
+ (NSDictionary *)codeErrorInfosToDictionnary:(BatchError *)error
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[BAESerializationHelper codeErrorInfosTypeToString:error] forKey:@"type"];
    
    if( [[error missingApplications] count] > 0 )
    {
        [dict setObject:[BAESerializationHelper missingApplicationToArray:[error missingApplications]] forKey:@"missingApps"];
    }
    
    return dict;
}

// Get the serialized value of a code error info type
+ (NSString *)codeErrorInfosTypeToString:(BatchError *)error
{
    switch ( [error invalidCodeError] )
    {
        case BatchInvalidCodeErrorAlreadyConsumed:
            return @"ALREADY_CONSUMED";
        case BatchInvalidCodeErrorMissingConditions:
            return @"MISSING_CONDITIONS";
        case BatchInvalidCodeErrorOfferAlreadyAcquired:
            return @"OFFER_ALREADY_ACQUIRED";
        case BatchInvalidCodeErrorOfferCapped:
            return @"OFFER_CAPPED";
        case BatchInvalidCodeErrorOfferExpired:
            return @"OFFER_EXPIRED";
        case BatchInvalidCodeErrorOfferNotStarted:
            return @"OFFER_NOT_STARTED";
        case BatchInvalidCodeErrorOfferPaused:
            return @"OFFER_PAUSED";
        case BatchInvalidCodeErrorOfferUnsupported:
            return @"OFFER_UNSUPPORTED";
        case BatchInvalidCodeErrorServerError:
            return @"SERVER_ERROR";
        case BatchInvalidCodeErrorUnknownCode:
            return @"UNKNOWN_CODE";
        case BatchInvalidCodeErrorUserNotTargeted:
            return @"USER_NOT_TARGETED";
        default:
            return @"SERVER_ERROR";
    }
}

// Serialize an array of missing application to JSON
+ (NSArray *)missingApplicationToArray:(NSArray *)missingApplications
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(id<BatchApplication> application in missingApplications)
    {
        [array addObject:@{@"scheme": [[application scheme] absoluteString]}];
    }
    
    return array;
}

#pragma mark Offer

// Serialize an offer to JSON
+ (NSString *)offerToJSON:(id<BatchOffer>)offer
{
    return [BAESerializationHelper dictionnaryToJSON:[BAESerializationHelper offerToDictionnary:offer]];
}

// Serialize an offer to a native dictionnary
+ (NSDictionary *)offerToDictionnary:(id<BatchOffer>)offer
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[offer offerReference] forKey:@"r"];
    [dict setObject:[BAESerializationHelper additionalParametersToArray:[offer offerAdditionalParameters]] forKey:@"data"];
    [dict setObject:[BAESerializationHelper featuresToArray:[offer features]] forKey:@"feat"];
    [dict setObject:[BAESerializationHelper resourcesToArray:[offer resources]] forKey:@"res"];
    [dict setObject:[BAESerializationHelper bundlesToArray:[offer bundlesReferences]] forKey:@"bundles"];

    return dict;
}

#pragma mark additional parameters

// Serialize additionnal parameters to JSON
+ (NSArray *)additionalParametersToArray:(NSDictionary *)additionalParameters
{
    NSMutableArray *params = [[NSMutableArray alloc] init];
    
    for (NSString *key in [additionalParameters allKeys])
    {
        NSDictionary *param = @{@"n" : key, @"v" : [additionalParameters objectForKey:key]};
        [params addObject:param];
    }
    
    return params;
}

#pragma mark features

// Serialize an array of feature to JSON
+ (NSArray *)featuresToArray:(NSArray *)features
{
    NSMutableArray *feats = [[NSMutableArray alloc] init];
    
    for (id<BatchFeature> feature in features)
    {
        [feats addObject:[BAESerializationHelper featureToDictionnary:feature]];
    }
    
    return feats;
}

// Serialize a feature to JSON
+ (NSDictionary *)featureToDictionnary:(id<BatchFeature>)feature
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    [dict setObject:[feature reference] forKey:@"r"];
    
    if( [feature isInBundle] )
    {
        [dict setObject:[feature bundleReference] forKey:@"b"];
    }
    
    if( [feature hasValue] )
    {
        [dict setObject:[feature value] forKey:@"val"];
    }
    
    if( ![feature isLifetime] )
    {
        [dict setObject:[NSNumber numberWithUnsignedInteger:[feature ttl]] forKey:@"ttl"];
    }
    
    return dict;
}

#pragma mark resources

// Serialize an array of resource to JSON
+ (NSArray *)resourcesToArray:(NSArray *)resources
{
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    for (id<BatchResource> resource in resources)
    {
        [res addObject:[BAESerializationHelper resourceToDictionnary:resource]];
    }
    
    return res;
}

// Serialize a resource to JSON
+ (NSDictionary *)resourceToDictionnary:(id<BatchResource>)resource
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    [dict setObject:[resource reference] forKey:@"r"];
    [dict setObject:[NSNumber numberWithUnsignedInteger:[resource quantity]] forKey:@"q"];
    
    if( [resource isInBundle] )
    {
        [dict setObject:[resource bundleReference] forKey:@"b"];
    }
    
    return dict;
}

#pragma mark bundles

// Serialize bundles to native array (does nothing actually)
+ (NSArray *)bundlesToArray:(NSArray *)bundles
{
    return bundles;
}

@end
