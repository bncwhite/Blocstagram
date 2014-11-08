//
//  BLCImagesTableViewController.h
//  Blocstagram
//
//  Created by Bradley White on 10/17/14.
//  Copyright (c) 2014 Bradley White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLCMediaTableViewCell.h"

@interface BLCImagesTableViewController : UITableViewController

@property (nonatomic) BLCMediaTableViewCell *desiredCell;
@property (nonatomic, weak) UIView *lastSelectedCommentView;
@property (nonatomic, assign) CGFloat lastKeyboardAdjustment;

@end
