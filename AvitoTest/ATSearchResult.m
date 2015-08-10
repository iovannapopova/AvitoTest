//
//  ATSearchResult.m
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATSearchResult.h"

@implementation ATSearchResult

-(instancetype)initWithName:(NSString*)name author:(NSString*)author previewImageUrl:(NSString*)previewImageUrl imageUrl:(NSString*)imageUrl  searchEngineID:(ATSearchEngineID)searchEngineID{
    self = [super init];
    if (self) {
        _name = [name copy];
        _author = [author copy];
        _previewImageUrl = [NSURL URLWithString:previewImageUrl];
        _imageUrl = [NSURL URLWithString:imageUrl];
        _searchEngineID = searchEngineID;
    }
    return self;
}

@end
