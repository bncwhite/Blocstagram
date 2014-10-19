//
//  BLCMediaTableViewCell.m
//  Blocstagram
//
//  Created by Bradley White on 10/17/14.
//  Copyright (c) 2014 Bradley White. All rights reserved.
//

#import "BLCMediaTableViewCell.h"
#import "BLCMedia.h"
#import "BLCComment.h"
#import "BLCUser.h"

@interface BLCMediaTableViewCell ()

@property (nonatomic, strong) UIImageView *mediaImageView;
@property (nonatomic, strong) UILabel *usernameAndCaptionLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) NSLayoutConstraint *imageHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *usernameAndCaptionLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *commentLabelHeightConstraint;

@end

static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *usernameLabelGray;
static UIColor *commentLabelGray;
static UIColor *linkColor;
static NSParagraphStyle *paragraphStyle;

@implementation BLCMediaTableViewCell

+ (void)load {
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    usernameLabelGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; /*#eeeeee*/
    commentLabelGray = [UIColor greenColor];//[UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]; /*#e5e5e5*/
    linkColor = [UIColor orangeColor];//[UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; /*#58506d*/
    
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -20.0;
    mutableParagraphStyle.paragraphSpacingBefore = 5;
    
    paragraphStyle = mutableParagraphStyle;
}

- (NSAttributedString *) usernameAndCaptionString {
    CGFloat usernameFontSize = 15;
    
    // Make a string that says "username caption text"
    NSString *baseString = [NSString stringWithFormat:@"%@ %@", self.mediaItem.user.userName, self.mediaItem.caption];
    //NSString *baseString = [NSString stringWithFormat:@"%@", self.mediaItem.user.userName];

    // Make an attributed string, with the "username" bold
    NSMutableAttributedString *mutableUsernameAndCaptionString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:usernameFontSize], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSRange captionRange = [baseString rangeOfString:self.mediaItem.caption];
    [mutableUsernameAndCaptionString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:captionRange];
    
    NSRange usernameRange = [baseString rangeOfString:self.mediaItem.user.userName];
    [mutableUsernameAndCaptionString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:usernameFontSize] range:usernameRange];
    [mutableUsernameAndCaptionString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
    
    return mutableUsernameAndCaptionString;
}

- (NSAttributedString *) commentString {
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] init];
    
    for (BLCComment *comment in self.mediaItem.comments) {
        // Make a string that says "username comment text" followed by a line break
        NSString *baseString = [NSString stringWithFormat:@"%@ %@\n", comment.from.userName, comment.text];
        
        // Make an attributed string, with the "username" bold
        
        NSMutableAttributedString *oneCommentString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : lightFont, NSParagraphStyleAttributeName : paragraphStyle}];
        
        NSRange captionRange = [baseString rangeOfString:comment.text];
        [oneCommentString addAttribute:NSForegroundColorAttributeName value:usernameLabelGray range:captionRange];
        
        NSRange usernameRange = [baseString rangeOfString:comment.from.userName];
        [oneCommentString addAttribute:NSFontAttributeName value:boldFont range:usernameRange];
        [oneCommentString addAttribute:NSForegroundColorAttributeName value:commentLabelGray range:usernameRange];
        
        [commentString appendAttributedString:oneCommentString];
    }
    
    return commentString;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    // Before layout, calculate the intrinsic size of the labels (the size they "want" to be), and add 20 to the height for some vertical padding.
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
    CGSize usernameLabelSize = [self.usernameAndCaptionLabel sizeThatFits:maxSize];
    CGSize commentLabelSize = [self.commentLabel sizeThatFits:maxSize];
    
    self.usernameAndCaptionLabelHeightConstraint.constant = usernameLabelSize.height + 20;
    self.commentLabelHeightConstraint.constant = commentLabelSize.height + 20;
    /*
    ////////////////////////////--------------------------
    self.mediaImageView.backgroundColor = [UIColor orangeColor];
    self.usernameAndCaptionLabel.backgroundColor = [UIColor greenColor];
    self.commentLabel.backgroundColor = [UIColor blueColor];
    ////////////////////////////--------------------------
    */
    
    self.imageHeightConstraint.constant = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
    
    // Hide the line between cells
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(self.bounds));
}

- (void) setMediaItem:(BLCMedia *)mediaItem {
    _mediaItem = mediaItem;
    self.mediaImageView.image = _mediaItem.image;
    self.usernameAndCaptionLabel.attributedText = [self usernameAndCaptionString];
    self.commentLabel.attributedText = [self commentString];
}

+ (CGFloat) heightForMediaItem:(BLCMedia *)mediaItem width:(CGFloat)width {
    
    // Make a cell
    BLCMediaTableViewCell *layoutCell = [[BLCMediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
    
    layoutCell.mediaItem = mediaItem;
    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));
        
    [layoutCell setNeedsLayout];
    [layoutCell layoutIfNeeded];
    
    // Get the actual height required for the cell
    //return CGRectGetMaxY(layoutCell.commentLabel.frame);
    
    return CGRectGetMaxY(layoutCell.mediaImageView.frame);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.mediaImageView = [UIImageView new];
        self.usernameAndCaptionLabel = [UILabel new];
        self.commentLabel = [UILabel new];
        self.commentLabel.numberOfLines = 0;
        
        for (UIView *view in @[self.mediaImageView, self.usernameAndCaptionLabel, self.commentLabel]) {
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        [self.mediaImageView addSubview:self.usernameAndCaptionLabel];
        [self.mediaImageView addSubview:self.commentLabel];
        
        [self.contentView addSubview:self.mediaImageView];
        
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_mediaImageView, _usernameAndCaptionLabel, _commentLabel);
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mediaImageView]|"
                                                                                 options: kNilOptions
                                                                                 metrics: nil
                                                                                   views: viewDictionary]];
        
        [self.mediaImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_usernameAndCaptionLabel][_commentLabel]"
                                                                                    options: kNilOptions
                                                                                    metrics: nil
                                                                                      views: viewDictionary]];
        
        [self.mediaImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_usernameAndCaptionLabel]|"
                                                                                    options: kNilOptions
                                                                                    metrics: nil
                                                                                      views: viewDictionary]];
        
        [self.mediaImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_commentLabel]|"
                                                                                    options: kNilOptions
                                                                                    metrics: nil
                                                                                      views: viewDictionary]];
        
        self.imageHeightConstraint = [NSLayoutConstraint constraintWithItem: _mediaImageView
                                                                  attribute: NSLayoutAttributeHeight
                                                                  relatedBy: NSLayoutRelationEqual
                                                                     toItem: nil
                                                                  attribute: NSLayoutAttributeNotAnAttribute
                                                                 multiplier: 1
                                                                   constant: 100];
        
        self.usernameAndCaptionLabelHeightConstraint = [NSLayoutConstraint constraintWithItem: _usernameAndCaptionLabel
                                                                                    attribute: NSLayoutAttributeHeight
                                                                                    relatedBy: NSLayoutRelationEqual
                                                                                       toItem: nil
                                                                                    attribute: NSLayoutAttributeNotAnAttribute
                                                                                   multiplier: 1
                                                                                     constant: 100];
        
        self.commentLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_commentLabel
                                                                         attribute: NSLayoutAttributeHeight
                                                                         relatedBy: NSLayoutRelationEqual
                                                                            toItem: nil
                                                                         attribute: NSLayoutAttributeNotAnAttribute
                                                                        multiplier: 1
                                                                          constant: 100];
        
        [self.contentView addConstraints:@[self.imageHeightConstraint,
                                           self.usernameAndCaptionLabelHeightConstraint,
                                           self.commentLabelHeightConstraint]];

        
        /*
        [self.mediaImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_usernameAndCaptionLabel]|"
                                                                                 options: kNilOptions
                                                                                 metrics: nil
                                                                                   views: viewDictionary]];
         */
        
        
        /*
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_commentLabel]|"
                                                                                 options: kNilOptions
                                                                                 metrics: nil
                                                                                   views: viewDictionary]];
        
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mediaImageView][_usernameAndCaptionLabel][_commentLabel]"
                                                                                 options: kNilOptions
                                                                                 metrics: nil
                                                                                   views: viewDictionary]];
         */
        
                
    }
    return self;
}

@end
