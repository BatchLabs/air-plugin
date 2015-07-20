//
//  Config.m
//  ane-ios
//
//  Created by Benoit Letondor on 24/06/2014.
//  Copyright (c) 2014 BastionSDK. All rights reserved.
//

#import "Config.h"

@implementation Config

// Constructor
- (id)initWithApiKey:(NSString *)apikey
{
    self = [super init];
    if (self)
    {
        _apikey = apikey;
    }
    return self;
}

// Set if the app can use IDFA
- (void)setCanUseIDFA:(BOOL)canUseIDFA
{
    _canUseIDFA = canUseIDFA;
}

@end
