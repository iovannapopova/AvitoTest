//
//  ATAlternatingSearchEngine.h
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATSearchEngine.h"

@interface ATAlternatingSearchEngine : NSObject

- (instancetype)initWithSearchEngines:(NSArray*)engines;
- (void)searchForString:(NSString*)string completionHandler:(void (^)(NSArray*, NSArray*, NSError*))completionHandler;
@end

