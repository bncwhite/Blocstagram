//
//  BLCImageFilterCell.h
//  Blocstagram
//
//  Created by Bradley White on 11/8/14.
//  Copyright (c) 2014 Bradley White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLCImageFilterCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) CGFloat thumbnailEdgeSize;

@end
