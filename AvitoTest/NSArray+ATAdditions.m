//
//  NSArray+ATAdditions.m
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "NSArray+ATAdditions.h"

@implementation NSArray (ATAdditions)

-(NSArray*)at_map:(id (^)(id, NSUInteger))transform{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id mappedObj = transform (obj, idx);
        if (mappedObj != nil) {
            [result addObject:mappedObj];
        }
    }];
    return [result copy];
}

-(NSArray*)at_filter:(BOOL (^)(id))include{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    for (id obj in self) {
        if (include(obj)) {
            [result addObject:obj];
        }
    }
    return [result copy];
}
@end
