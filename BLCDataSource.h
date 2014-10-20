//
//  BLCDataSource.h
//  Blocstagram
//
//  Created by Bradley White on 10/17/14.
//  Copyright (c) 2014 Bradley White. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLCMedia;

@interface BLCDataSource : NSObject

+(instancetype) sharedInstance;

@property (nonatomic, strong, readonly) NSMutableArray *mediaItems;

- (void) deleteMediaItem:(BLCMedia *)item;

@end
