//
//  ATSearchOperation.h
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATSearchEngine.h"

@interface ATSearchOperation : NSOperation

@property (nonatomic,copy,readonly) NSString* query;
@property (nonatomic,copy,readonly) NSArray* results;
@property (nonatomic,readonly) NSError* error;

- (instancetype)initWithQuery:(NSString*)query searchEngine:(id<ATSearchEngine>)searchEngine;

@end
