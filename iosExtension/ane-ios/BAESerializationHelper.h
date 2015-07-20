//
//  BAESerializationHelper.h
//  ane-ios
//
//  Created by Benoit Letondor on 29/04/2014.
//  Copyright (c) 2014 BastionSDK. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Batch/BatchError.h>
#import <Batch/BatchOffer.h>
#import <Batch/BatchAds.h>
#import "Config.h"

// Helper to serialiaze Batch object from/to JSON
@interface BAESerializationHelper : NSObject

// Serialize a Config object from JSON
+ (Config *)configFromJSON:(NSString *)json;

// Serialize an array of feature to JSON
+ (NSArray *)featuresToArray:(NSArray *)features;
// Serialize an array of resource to JSON
+ (NSArray *)resourcesToArray:(NSArray *)resources;
// Serialize an offer to JSON
+ (NSDictionary *)offerToDictionnary:(id<BatchOffer>)offer;

// Get the serialized value of an error
+ (NSString *)reasonToString:(BatchError *)error;
// Is this error about promocode
+ (BOOL)shouldAddCodeErrorInfos:(BatchError *)error;
// Serialize the code error info to JSON
+ (NSDictionary *)codeErrorInfosToDictionnary:(BatchError *)error;

// Serialize native dictionnary to JSON
+ (NSString *)dictionnaryToJSON:(NSDictionary *)dictionnary;

@end
