//
//  UIImage+BLCImageUtilitiesAll_In_One.m
//  Blocstagram
//
//  Created by Bradley White on 11/5/14.
//  Copyright (c) 2014 Bradley White. All rights reserved.
//

#import "UIImage+BLCImageUtilitiesAll_In_One.h"
#import "UIImage+BLCImageUtilities.h"


@implementation UIImage (BLCImageUtilitiesAll_In_One)

- (UIImage *) imageByScalingToSize:(CGSize)size andCroppingWithRect:(CGRect)rect
{
    [self imageWithFixedOrientation];
    [self imageResizedToMatchAspectRatioOfSize:size];
    
    //CGRect cropRect = rect;
    rect.origin.x = (CGRectGetMinX(rect) + (self.size.width - CGRectGetWidth(rect)) / 2);
    
    [self imageCroppedToRect:rect];
        
    return self;
}

@end
