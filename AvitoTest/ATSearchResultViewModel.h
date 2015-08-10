//
//  ATSearchResultViewModel.h
//  AvitoTest
//
//  Created by Iovanna Popova on 06.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ATCellType) {
    ATCellTypeLeft,
    ATCellTypeRight
};

@class ATSearchResult;

@interface ATSearchResultViewModel : NSObject

- (instancetype)initWithSearchResult:(ATSearchResult*)searchResult index:(NSInteger)index NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, readonly) NSString* name;
@property (nonatomic, copy, readonly) NSString* author;
@property (nonatomic, strong, readonly) NSURL* previewImageUrl;
@property (nonatomic, readonly) ATCellType cellType;

@end
