//
//  ATAdditionsTests.m
//  AvitoTest
//
//  Created by Iovanna Popova on 16.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSArray+ATAdditions.h"

@interface ATAdditionsTests : XCTestCase

@end

@implementation ATAdditionsTests

- (void)test_whenArrayIsEmpty_retutnsEmptyArray{
    NSArray* emptyArray = @[];
    NSArray* mappedArray = [emptyArray at_map:^id(id obj, NSUInteger idx) {
        return [NSString stringWithFormat:@"[%d]",idx];
    }];
    XCTAssertEqual(mappedArray.count, 0);
}

- (void)test_whenReturnValueIsNil_retutnsEmptyArray{
    NSArray* array = @[@1,@2,@3];
    NSArray* mappedArray = [array at_map:^id(id obj, NSUInteger idx) {
        return nil;
    }];
    XCTAssertEqual(mappedArray.count, 0);
}

@end
