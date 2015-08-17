//
//  ATRemoteSearchEngine.h
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATSearchEngine.h"

typedef NSArray*(^ATRemoteSearchEngineResultParser)(NSDictionary* resultDictionary);

@interface ATRemoteSearchEngine : NSObject <ATSearchEngine>

-(instancetype)initWithTemplateURL:(NSURL*)templateURL searchTermParameterName:(NSString*)searchTermParameterName resultParser:(ATRemoteSearchEngineResultParser)resultParser;

- (NSURL*)urlForSearchTerm:(NSString*)term;

@end



