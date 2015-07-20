//
//  BatchUnlockDelegate.m
//  ane-ios
//
//  Created by Benoit Letondor on 24/06/2014.
//  Copyright (c) 2014 BastionSDK. All rights reserved.
//

#import "BAUnlockDelegate.h"
#import "BAESerializationHelper.h"

@implementation BAUnlockDelegate
{
    FREContext _context;
    NSString *_currentCode;
}

// Constructor
- (id)initWithContext:(FREContext)context
{
    self = [super init];
    if( self )
    {
        _context = context;
    }
    return self;
}

#pragma mark BatchUnlockDelegate

- (void)automaticOfferRedeemed:(id<BatchOffer>)offer
{
    const uint8_t* eventCode = (const uint8_t*) [[BAESerializationHelper dictionnaryToJSON:[BAESerializationHelper offerToDictionnary:offer]] UTF8String];
    const uint8_t* eventLevel = (const uint8_t*) [@"onRedeemOffer" UTF8String];
    
    FREDispatchStatusEventAsync(_context, eventCode, eventLevel);
}

- (void)URLWithCodeFound:(NSString *)code
{
    _currentCode = code;
    
    const uint8_t* eventCode = (const uint8_t*) [code UTF8String];
    const uint8_t* eventLevel = (const uint8_t*) [@"onURLWithCodeFound" UTF8String];
    
    FREDispatchStatusEventAsync(_context, eventCode, eventLevel);
}


- (void)URLWithCodeRedeemed:(id<BatchOffer>)offer
{
    NSMutableDictionary *resp = [[NSMutableDictionary alloc] init];
    
    [resp setObject:_currentCode forKey:@"code"];
    [resp setObject:[BAESerializationHelper offerToDictionnary:offer] forKey:@"offer"];
    
    const uint8_t* eventCode = (const uint8_t*) [[BAESerializationHelper dictionnaryToJSON:resp] UTF8String];
    const uint8_t* eventLevel = (const uint8_t*) [@"onURLCodeSuccess" UTF8String];
    
    FREDispatchStatusEventAsync(_context, eventCode, eventLevel);
    
    _currentCode = nil;
}

- (void)URLWithCodeFailed:(BatchError *)error
{
    NSMutableDictionary *resp = [[NSMutableDictionary alloc] init];
    
    [resp setObject:_currentCode forKey:@"code"];
    [resp setObject:[BAESerializationHelper reasonToString:error] forKey:@"reason"];
    
    if( [BAESerializationHelper shouldAddCodeErrorInfos:error] )
    {
        [resp setObject:[BAESerializationHelper codeErrorInfosToDictionnary:error] forKey:@"infos"];
    }
    
    
    const uint8_t* eventCode = (const uint8_t*) [[BAESerializationHelper dictionnaryToJSON:resp] UTF8String];
    const uint8_t* eventLevel = (const uint8_t*) [@"onURLCodeFailed" UTF8String];
    
    FREDispatchStatusEventAsync(_context, eventCode, eventLevel);
    
    _currentCode = nil;
}

@end
