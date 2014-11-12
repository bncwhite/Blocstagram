//
//  BLCMediaTests.m
//  Blocstagram
//
//  Created by Bradley White on 11/11/14.
//  Copyright (c) 2014 Bradley White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BLCMedia.h"
#import "BLCUser.h"
#import "BLCComment.h"
#import <Foundation/Foundation.h>

@interface BLCMediaTests : XCTestCase

@end

@implementation BLCMediaTests

- (void)testThatInitializationWorks
{
    NSDictionary *sourceDictionary = @{@"id" : @"101114",
                                       @"images" : @{@"standard_resolution" : @{@"url": @"http://www.example.com/example.jpg"}},
                                       @"caption" : @{@"text" : @"This is a comment"},
                                       @"comments" : @{@"data" : @[@{@"id" : @"8675309", @"text" : @"Sample Comment"}]},
                                       @"user_has_liked" : @"true"
                                       };
    
    BLCMedia *testMedia = [[BLCMedia alloc] initWithDictionary:sourceDictionary];
    
    XCTAssertEqualObjects(testMedia.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(testMedia.mediaURL, [NSURL URLWithString:sourceDictionary[@"images"][@"standard_resolution"][@"url"]], @"The mediaURL should be equal");
    XCTAssertEqualObjects(testMedia.caption, sourceDictionary[@"caption"][@"text"], @"The caption should be equal");
    XCTAssertTrue(testMedia.comments.count > 0, @"The comments should be equal");
    XCTAssertTrue(testMedia.likeState <= 3);
    XCTAssertTrue(testMedia.numberOfLikes >= 0);
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
