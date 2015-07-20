//
//  BatchUnlockDelegate.h
//  ane-ios
//
//  Created by Benoit Letondor on 24/06/2014.
//  Copyright (c) 2014 BastionSDK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Batch/BatchUnlock.h>
#import "FlashRuntimeExtensions.h"

// Class that implements the BatchUnlockDelegate
@interface BAUnlockDelegate : NSObject<BatchUnlockDelegate>

// Constructor
- (id)initWithContext:(FREContext)context;

@end
