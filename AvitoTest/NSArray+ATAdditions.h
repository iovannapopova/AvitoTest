//
//  NSArray+ATAdditions.h
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ATAdditions)

-(NSArray*)at_map:(id (^)(id, NSUInteger))transform;
-(NSArray*)at_filter:(BOOL (^)(id))include;

@end
