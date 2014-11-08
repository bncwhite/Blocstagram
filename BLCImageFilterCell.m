//
//  BLCImageFilterCell.m
//  Blocstagram
//
//  Created by Bradley White on 11/8/14.
//  Copyright (c) 2014 Bradley White. All rights reserved.
//

#import "BLCImageFilterCell.h"

@implementation BLCImageFilterCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        static NSInteger imageViewTag = 1000;
        static NSInteger labelTag = 1001;
        
        self.thumbnail = (UIImageView *)[self.contentView viewWithTag:imageViewTag];
        self.label = (UILabel *)[self.contentView viewWithTag:labelTag];
        
        self.thumbnail.tag = imageViewTag;
        self.label.tag = labelTag;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.thumbnail) {
        self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.thumbnailEdgeSize, self.thumbnailEdgeSize)];
        self.thumbnail.contentMode = UIViewContentModeScaleAspectFill;
        self.thumbnail.clipsToBounds = YES;
        
        [self.contentView addSubview:self.thumbnail];
    }
    
    if (!self.label) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.thumbnailEdgeSize, self.thumbnailEdgeSize, 20)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
        
        [self.contentView addSubview:self.label];
    }
}

-(void)setThumbnailEdgeSize:(CGFloat)thumbnailEdgeSize
{
    _thumbnailEdgeSize = thumbnailEdgeSize;
}


@end
