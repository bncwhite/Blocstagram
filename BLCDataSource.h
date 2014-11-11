//
//  BLCDataSource.h
//  Blocstagram
//
//  Created by Bradley White on 10/17/14.
//  Copyright (c) 2014 Bradley White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BLCImagesTableViewController.h"

@class BLCMedia;

typedef void (^BLCNewItemCompletionBlock)(NSError *error);

@interface BLCDataSource : NSObject

extern NSString *const BLCImageFinishedNotification;

+(instancetype) sharedInstance;

+ (NSString *) instagramClientID;

@property (nonatomic, strong, readonly) NSMutableArray *mediaItems;

@property (nonatomic, strong, readonly) NSString *accessToken;

- (void) deleteMediaItem:(BLCMedia *)item;

- (void) downloadImageForMediaItem:(BLCMedia *)mediaItem;

- (void) requestNewItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;

- (void) requestOldItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;

- (void) toggleLikeOnMediaItem:(BLCMedia *)mediaItem;

- (void) commentOnMediaItem:(BLCMedia *)mediaItem withCommentText:(NSString *)commentText;

@end
