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

#pragma mark - at_map

- (void)test_mapwhenArrayIsEmpty_retutnsEmptyArray{
    NSArray* emptyArray = @[];
    NSArray* mappedArray = [emptyArray at_map:^id(id obj, NSUInteger idx) {
        return [NSString stringWithFormat:@"[%d]",idx];
    }];
    XCTAssertEqual(mappedArray.count, 0);
}

- (void)test_mapwhenReturnValueIsNil_retutnsEmptyArray{
    NSArray* array = @[@1,@2,@3];
    NSArray* mappedArray = [array at_map:^id(id obj, NSUInteger idx) {
        return nil;
    }];
    XCTAssertEqual(mappedArray.count, 0);
}

- (void)test_mapwhenArrayIsNotEmpty_retutnsMappedArray{
    NSArray* array = @[@1,@2,@3];
    NSArray* mappedArray = [array at_map:^id(NSNumber* obj, NSUInteger idx) {
        return [obj stringValue];
    }];
    XCTAssertEqual(mappedArray.count, 3);
    XCTAssertEqualObjects([mappedArray firstObject], @"1");
}

#pragma mark - at_filter

- (void)test_filerwhenArrayIsEmptyAndFilterYes_retutnsEmptyArray{
    NSArray* emptyArray = @[];
    NSArray* mappedArray = [emptyArray at_filter:^BOOL(id obj){
        return YES;
    }];
    XCTAssertEqual(mappedArray.count, 0);
}

- (void)test_filerwhenArrayIsEmptyAndFilterNo_retutnsEmptyArray{
    NSArray* emptyArray = @[];
    NSArray* mappedArray = [emptyArray at_filter:^BOOL(id obj){
        return YES;
    }];
    XCTAssertEqual(mappedArray.count, 0);
}

- (void)test_filterwhenReturnValueIsNO_retutnsEmptyArray{
    NSArray* array = @[@1,@2,@3];
    NSArray* mappedArray = [array at_filter:^BOOL(id obj) {
        return NO;
    }];
    XCTAssertEqual(mappedArray.count, 0);
}


- (void)test_filterwhenReturnValueIsYES_retutnsEqualArray{
    NSArray* array = @[@1,@2,@3];
    NSArray* mappedArray = [array at_filter:^BOOL(id obj) {
        return YES;
    }];
    XCTAssertEqualObjects(mappedArray, array);
}

- (void)test_whenFilterIsExist_retutnsEmptyArray{
    NSArray* array = @[@1,@2,@3];
    NSArray* mappedArray = [array at_filter:^BOOL(NSNumber* obj) {
        return [obj compare:@3] == NSOrderedDescending;
    }];
    XCTAssertEqual(mappedArray.count, 0);
}

- (void)test_whenFilterIsExist_retutnsEqualArray{
    NSArray* array = @[@1,@2,@3];
    NSArray* mappedArray = [array at_filter:^BOOL(NSNumber* obj) {
        return [obj compare:@4] == NSOrderedAscending;
    }];
    XCTAssertEqualObjects(mappedArray, array);
}


- (void)test_whenFilterIsExist_retutnsArrayWithxCount{
    NSArray* array = @[@1,@2,@3];
    NSArray* mappedArray = [array at_filter:^BOOL(NSNumber* obj) {
        return [obj compare:@3] == NSOrderedSame;
    }];
    XCTAssertEqual(mappedArray.count, 1);
}

@end
