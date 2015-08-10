//
//  ATSearchOperation.m
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATSearchOperation.h"

@interface ATSearchOperation ()

@property (nonatomic,copy,readwrite) NSArray* results;
@property (nonatomic,strong,readwrite) NSError* error;
@property (nonatomic,readonly) id<ATSearchEngine> searchEngine;
@property (nonatomic,readwrite,getter=isExecuting) BOOL executing;
@property (nonatomic,readwrite,getter=isFinished) BOOL finished;

@end

@implementation ATSearchOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)initWithQuery:(NSString*)query searchEngine:(id<ATSearchEngine>)searchEngine {
    self = [super init];
    if (self) {
        _query = [query copy];
        _searchEngine = searchEngine;
        _executing = _finished = NO;
    }
    return self;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (void)start {
    if (self.isCancelled) {
        [self completeOperation];
        return;
    }
    
    self.executing = YES;
    
    [self.searchEngine searchForString:self.query completionHandler:^(NSArray* results, NSError* error) {
        self.results = results;
        self.error = error;
        [self completeOperation];
    }];
}

- (void)completeOperation {
    self.executing = NO;
    self.finished = YES;
}

- (void)setExecuting:(BOOL)executing {
    if (executing != _executing) {
        [self willChangeValueForKey:@"isExecuting"];
        _executing = executing;
        [self didChangeValueForKey:@"isExecuting"];
    }
}

- (void)setFinished:(BOOL)finished {
    if (finished != _finished) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = finished;
        [self didChangeValueForKey:@"isFinished"];
    }
}

@end
