//
//  BLCMediaTableViewCellTests.m
//  Blocstagram
//
//  Created by Bradley White on 11/11/14.
//  Copyright (c) 2014 Bradley White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BLCMediaTableViewCell.h"
#import "BLCMedia.h"
#import "BLCComment.h"
#import "BLCUser.h"

@interface BLCMediaTableViewCellTests : XCTestCase

@end

@implementation BLCMediaTableViewCellTests

- (void)testThatInitializationWorks {
    
    NSDictionary *userSourceDictionary = @{@"id": @"8675309",
                                       @"username" : @"d'oh",
                                       @"full_name" : @"Homer Simpson",
                                       @"profile_picture" : @"http://www.example.com/example.jpg"};
    
    BLCUser *testUser = [[BLCUser alloc] initWithDictionary:userSourceDictionary];
    
    BLCMedia *media = [BLCMedia new];
    media.user = testUser;
    media.image = [UIImage imageNamed:@"starship.jpg"];
    CGFloat starshipHeight = media.image.size.height;
    XCTAssertTrue([BLCMediaTableViewCell heightForMediaItem:media width:375] != starshipHeight);
    XCTAssertNotEqualWithAccuracy([BLCMediaTableViewCell heightForMediaItem:media width:375], starshipHeight, 0);
    NSLog(@"media one cell size: %f, original size: %f", [BLCMediaTableViewCell heightForMediaItem:media width:375], starshipHeight);
    
    media.image = [UIImage imageNamed:@"captainActors.jpg"];
    CGFloat actorsHeight = media.image.size.height;
    XCTAssertTrue([BLCMediaTableViewCell heightForMediaItem:media width:375] != actorsHeight);
    XCTAssertGreaterThanOrEqual([BLCMediaTableViewCell heightForMediaItem:media width:375], actorsHeight);
    NSLog(@"media two cell size: %f, original size: %f", [BLCMediaTableViewCell heightForMediaItem:media width:375], actorsHeight);
    
    media.image = [UIImage imageNamed:@"captainStarfleet.jpeg"];
    CGFloat captainsHeight = media.image.size.height;
    XCTAssertTrue([BLCMediaTableViewCell heightForMediaItem:media width:375] != captainsHeight);
    XCTAssertLessThanOrEqual(media.image.size.height, [BLCMediaTableViewCell heightForMediaItem:media width:375]);
    NSLog(@"media three cell size: %f, original size: %f", [BLCMediaTableViewCell heightForMediaItem:media width:375], captainsHeight);
    
    

}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
