//
//  ATRemoteSearchEngineTests.m
//  AvitoTest
//
//  Created by Iovanna Popova on 17.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ATRemoteSearchEngine.h"

@interface ATRemoteSearchEngineTests : XCTestCase

@end

@implementation ATRemoteSearchEngineTests

- (void)test_whenTemplateUrlAlreadyHasSearchTerm_replacesIt{
    NSURL* templateUrl = [NSURL URLWithString:@"https://itunes.apple.com/search?term=po"];
    ATRemoteSearchEngine* engine = [[ATRemoteSearchEngine alloc] initWithTemplateURL:templateUrl searchTermParameterName:@"term" resultParser:nil];
    NSURL* url = [engine urlForSearchTerm:@"op"];
    NSURL* expectedUrl = [NSURL URLWithString:@"https://itunes.apple.com/search?term=op"];
    XCTAssertEqualObjects(url, expectedUrl);
}

@end
