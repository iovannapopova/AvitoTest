//
//  ATAlternatingSearchEngine.m
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATAlternatingSearchEngine.h"
#import "ATSearchOperation.h"
#import "NSArray+ATAdditions.h"

@interface ATAlternatingSearchEngine ()

@property (nonatomic,copy) NSArray* searchEngines;
@property (nonatomic,strong) NSOperationQueue* searchQueue;

@end

@implementation ATAlternatingSearchEngine

- (instancetype)initWithSearchEngines:(NSArray*)engines {
    self = [super init];
    if (self) {
        _searchEngines = [engines copy];
        _searchQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)searchForString:(NSString*)string completionHandler:(void (^)(NSArray*, NSArray*, NSError*))completionHandler {
    [self.searchQueue cancelAllOperations];
    
    NSBlockOperation* completionOperation = [[NSBlockOperation alloc] init];
    __weak typeof(completionOperation) weakOp = completionOperation;
    [completionOperation addExecutionBlock:^{
        typeof(weakOp) strongOp = weakOp;
        if (!strongOp) {
            return;
        }
        
        NSArray* failedOperations = [strongOp.dependencies at_filter:^BOOL(ATSearchOperation* searchOperation) { return searchOperation.error != nil; }];
        if ([failedOperations count] > 0 && !strongOp.isCancelled) {
            ATSearchOperation* anyFailedOperation = [failedOperations firstObject];
            dispatch_async(dispatch_get_main_queue(), ^{ completionHandler(nil, nil, anyFailedOperation.error); });
            return;
        }
        
        NSArray* operationsResults = [strongOp.dependencies at_map:^NSArray*(ATSearchOperation* searchOperation, NSUInteger idx) { return searchOperation.results; }];
        
        if (!strongOp.isCancelled) {
            dispatch_async(dispatch_get_main_queue(), ^{ completionHandler([operationsResults firstObject], [operationsResults lastObject], nil); });
        }
    }];
    for (id<ATSearchEngine> engine in self.searchEngines) {
        ATSearchOperation* searchOperation = [[ATSearchOperation alloc] initWithQuery:string searchEngine:engine];
        [completionOperation addDependency:searchOperation];
        [self.searchQueue addOperation:searchOperation];
    }
    [self.searchQueue addOperation:completionOperation];
}

@end
