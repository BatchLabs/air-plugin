//
//  BAAdDisplayDelegate.m
//  ane-ios
//
//  Created by Benoit Letondor on 13/01/15.
//  Copyright (c) 2015 BastionSDK. All rights reserved.
//

#import "BAAdDisplayDelegate.h"

@implementation BAAdDisplayDelegate
{
    FREContext _context;
}

static BAAdDisplayDelegate *instance;

// Instanciate a new delegate for the given context
+ (instancetype)createNewDelegateWithContext:(FREContext)ctx
{
    instance = [[BAAdDisplayDelegate alloc] initWithContext:ctx];
    return instance;
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

#pragma mark BatchAdsDisplayDelegate

- (void)adDidAppear:(NSString *)placement
{
    const uint8_t* eventCode = (const uint8_t*) [@"" UTF8String];
    const uint8_t* eventLevel = (const uint8_t*) [@"AdOnAdDisplayed" UTF8String];
    
    FREDispatchStatusEventAsync(_context, eventCode, eventLevel);
}

- (void)adDidDisappear:(NSString *)placement
{
    const uint8_t* eventCode = (const uint8_t*) [@"" UTF8String];
    const uint8_t* eventLevel = (const uint8_t*) [@"AdOnAdClosed" UTF8String];
    
    FREDispatchStatusEventAsync(_context, eventCode, eventLevel);
    
    instance = nil;
}

- (void)adClicked:(NSString *)placement
{
    const uint8_t* eventCode = (const uint8_t*) [@"" UTF8String];
    const uint8_t* eventLevel = (const uint8_t*) [@"AdOnAdClicked" UTF8String];
    
    FREDispatchStatusEventAsync(_context, eventCode, eventLevel);
}

- (void)adCancelled:(NSString *)placement
{
    const uint8_t* eventCode = (const uint8_t*) [@"" UTF8String];
    const uint8_t* eventLevel = (const uint8_t*) [@"AdOnAdCancelled" UTF8String];
    
    FREDispatchStatusEventAsync(_context, eventCode, eventLevel);
}

- (void)adNotDisplayed:(NSString *)placement
{
    const uint8_t* eventCode = (const uint8_t*) [@"" UTF8String];
    const uint8_t* eventLevel = (const uint8_t*) [@"AdOnNoAdDisplayed" UTF8String];
    
    FREDispatchStatusEventAsync(_context, eventCode, eventLevel);
    
    instance = nil;
}

@end
