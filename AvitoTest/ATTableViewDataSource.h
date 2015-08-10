//
//  ATTableViewDataSource.h
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ATSearchResultViewModel.h"
#import "ATSearchResult.h"

@protocol ATTableViewDelegate <NSObject>

-(void)setUserInteractionEnabled:(BOOL)enable;

@end

@interface ATTableViewDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSArray* searchResultsArray;
@property (nonatomic,assign) ATSearchEngineID searchEngineType;
@property (nonatomic,weak) id <ATTableViewDelegate> uiDelegate;

@end