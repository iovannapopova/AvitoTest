//
//  ATRemoteSearchEngine.m
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATRemoteSearchEngine.h"
#import "NSArray+ATAdditions.h"

@interface ATRemoteSearchEngine()

@property (nonatomic,readonly) NSURL* templateURL;
@property (nonatomic,readonly) NSString* searchTermParameterName;
@property (nonatomic,readonly) ATRemoteSearchEngineResultParser resultParser;
@property (nonatomic,readonly) NSURLSession* session;

@end

@implementation ATRemoteSearchEngine

-(instancetype)initWithTemplateURL:(NSURL*)templateURL searchTermParameterName:(NSString *)searchTermParameterName resultParser:(ATRemoteSearchEngineResultParser)resultParser{
    self = [super init];
    if (self) {
        _templateURL = templateURL;
        _searchTermParameterName = searchTermParameterName;
        _resultParser = resultParser;
    }
    return self;
}

-(NSURLSession*)session{
    return [NSURLSession sharedSession];
}

-(void)searchForString:(NSString *)string completionHandler:(void (^)(NSArray *, NSError *))completionHandler{
    
    NSURL* url = [self urlForSearchTerm:string];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300) {
                NSError* jsonError;
                NSDictionary* resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                if (resultDictionary && self.resultParser) {
                    dispatch_async(dispatch_get_main_queue(), ^{ completionHandler(self.resultParser(resultDictionary), nil); });
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), ^{ completionHandler(nil, jsonError); });
                }
            }
            else {
                NSError* httpError = [NSError errorWithDomain:@"ATRemoteSearchEngine" code:httpResponse.statusCode userInfo:nil];
                dispatch_async(dispatch_get_main_queue(), ^{ completionHandler(nil, httpError); });
            }
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{ completionHandler(nil, error); });
        }
    }];
    [task resume];
}

- (NSURL*)urlForSearchTerm:(NSString*)term{
    NSURLComponents* urlComponents = [NSURLComponents componentsWithURL:self.templateURL resolvingAgainstBaseURL:NO];
    NSURLQueryItem* queryItem = [[NSURLQueryItem alloc] initWithName:self.searchTermParameterName value:term];
    NSArray* items = urlComponents.queryItems ?: @[ ];
    items = [items at_filter:^BOOL(NSURLQueryItem* queryItem) {
        return ![queryItem.name isEqualToString:self.searchTermParameterName];
    }];
    NSMutableArray* mutableItems = [items mutableCopy];
    [mutableItems addObject:queryItem];
    urlComponents.queryItems = mutableItems;
    return urlComponents.URL;
}

@end


