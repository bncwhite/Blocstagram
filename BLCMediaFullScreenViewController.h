//
//  BLCMediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Bradley White on 10/21/14.
//  Copyright (c) 2014 Bradley White. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCMedia;

@protocol BLCMediaFullScreenViewControllerDelegate <NSObject>

- (void) shareMediaNow;

@end

@interface BLCMediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) BLCMedia *media;

@property (nonatomic, weak) id <BLCMediaFullScreenViewControllerDelegate> delegate;

- (instancetype) initWithMedia:(BLCMedia *)media;

- (void) centerScrollView;

- (void) recalculateZoomScale;

@end