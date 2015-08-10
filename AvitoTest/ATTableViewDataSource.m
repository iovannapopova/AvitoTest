//
//  ATTableViewDataSource.m
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATTableViewDataSource.h"
#import "ATViewController.h"
#import "ATTableViewCell.h"

@implementation ATTableViewDataSource

-(void)setSearchResultsArray:(NSArray *)searchResultsArray{
    if (_searchResultsArray == searchResultsArray) {
        return;
    }
    _searchResultsArray = searchResultsArray;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.searchResultsArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* reuseID = @"CellID";
    
    ATTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (cell == nil) {
        cell = [[ATTableViewCell alloc] initWithReuseID:reuseID];
        cell.delegate = (ATViewController*)self.uiDelegate;
    }
    
    cell.searchResultViewModel = (ATSearchResultViewModel*)[self.searchResultsArray objectAtIndex:indexPath.row];
    return cell;
}

@end
