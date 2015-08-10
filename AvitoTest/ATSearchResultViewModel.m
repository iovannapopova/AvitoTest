//
//  ATSearchResultViewModel.m
//  AvitoTest
//
//  Created by Iovanna Popova on 06.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATSearchResultViewModel.h"
#import "ATSearchResult.h"

@implementation ATSearchResultViewModel

- (instancetype)initWithSearchResult:(ATSearchResult*)searchResult index:(NSInteger)index {
    self = [super init];
    if (self) {
        _name = [searchResult.name copy];
        _author = [searchResult.author copy];
        _previewImageUrl = searchResult.previewImageUrl;
        
        switch (searchResult.searchEngineID) {
            case ATSearchEngineIDiTunes:
                _cellType = index % 2 ? ATCellTypeLeft : ATCellTypeRight;
                break;
                
            case ATSearchEngineIDGitHub:
                _cellType = index % 2 ? ATCellTypeRight : ATCellTypeLeft;
                break;
                
            default:
                break;
        }
    }
    return self;
}

@end
