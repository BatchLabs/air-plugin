//
//  Config.h
//  ane-ios
//
//  Created by Benoit Letondor on 24/06/2014.
//  Copyright (c) 2014 BastionSDK. All rights reserved.
//

#import <Foundation/Foundation.h>

// Object that matches Android's Config object
@interface Config : NSObject

@property(nonatomic) NSString *apikey;
@property(nonatomic) BOOL canUseIDFA;

// Constructor
- (id)initWithApiKey:(NSString *)apikey;
// Set if the app can use IDFA
- (void)setCanUseIDFA:(BOOL)canUseIDFA;

@end
