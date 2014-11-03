//
//  BLCLikeButton.h
//  Blocstagram
//
//  Created by Bradley White on 11/1/14.
//  Copyright (c) 2014 Bradley White. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BLCLikeState) {
    BLCLikeStateNotLiked,
    BLCLikeStateLiking,
    BLCLikeStateLiked,
    BLCLikeStateUnliking
};

@interface BLCLikeButton : UIButton

@property (nonatomic, assign) BLCLikeState likeButtonState;

@end
