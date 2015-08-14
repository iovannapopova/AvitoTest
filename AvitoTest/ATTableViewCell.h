//
//  ATTableViewCell.h
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATSearchResult.h"
#import "ATSearchResultViewModel.h"
@class ATTableViewCell;

@protocol CellDelegate <NSObject>

-(void)userDidTouch:(UITapGestureRecognizer*)recognizer image:(UIImage*)image cell:(ATTableViewCell*)cell;

@end

@interface ATTableViewCell : UITableViewCell

-(instancetype)initWithReuseID:(NSString*)reuseID;

@property (nonatomic, strong) ATSearchResultViewModel* searchResultViewModel;
@property (nonatomic, weak) id <CellDelegate> delegate;
@property (nonatomic, readonly) UIImageView* objectImageView;

@end
