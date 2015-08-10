//
//  ATSearchEngine.h
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

@protocol ATSearchEngine <NSObject>

-(void)searchForString:(NSString*)string completionHandler:(void(^)(NSArray*,NSError*))completionHandler;

@end
