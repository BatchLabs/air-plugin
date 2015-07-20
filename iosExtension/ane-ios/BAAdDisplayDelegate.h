//
//  BAAdDisplayDelegate.h
//  ane-ios
//
//  Created by Benoit Letondor on 13/01/15.
//  Copyright (c) 2015 BastionSDK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import <Batch/BatchAds.h>

// Class that implements the BatchAdsDisplayDelegate
@interface BAAdDisplayDelegate : NSObject<BatchAdsDisplayDelegate>

// Instanciate a new delegate for the given context
+ (instancetype)createNewDelegateWithContext:(FREContext)ctx;

@end
