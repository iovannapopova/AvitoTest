//
//  ATSearchResultViewModelTests.m
//  AvitoTest
//
//  Created by Iovanna Popova on 17.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ATSearchResultViewModel.h"

@interface ATSearchResultViewModelTests : XCTestCase

@end

@implementation ATSearchResultViewModelTests

- (void)test_whenIndexIsEvenAndIdIsGithub_returnATCellTypeLeft{
    ATSearchResultViewModel* viewModel = [[ATSearchResultViewModel alloc] initWithSearchResult:nil index:0];
    ATCellType cellType =  [viewModel cellTypeWithIndex:0 searchIngine:ATSearchEngineIDGitHub];
    XCTAssertEqual(cellType, ATCellTypeLeft);
}


- (void)test_whenIndexIsEvenAndIdIsItunes_returnATCellTypeRight{
    ATSearchResultViewModel* viewModel = [[ATSearchResultViewModel alloc] initWithSearchResult:nil index:0];
    ATCellType cellType =  [viewModel cellTypeWithIndex:0 searchIngine:ATSearchEngineIDiTunes];
    XCTAssertEqual(cellType, ATCellTypeRight);
}


- (void)test_whenIndexIsOddAndIdIsItunes_returnATCellTypeLeft{
    ATSearchResultViewModel* viewModel = [[ATSearchResultViewModel alloc] initWithSearchResult:nil index:1];
    ATCellType cellType =  [viewModel cellTypeWithIndex:1 searchIngine:ATSearchEngineIDiTunes];
    XCTAssertEqual(cellType, ATCellTypeLeft);
}


- (void)test_whenIndexIsOddAndIdIsItunes_returnATCellTypeRight{
    ATSearchResultViewModel* viewModel = [[ATSearchResultViewModel alloc] initWithSearchResult:nil index:0];
    ATCellType cellType =  [viewModel cellTypeWithIndex:0 searchIngine:ATSearchEngineIDiTunes];
    XCTAssertEqual(cellType, ATCellTypeRight);
}

@end
