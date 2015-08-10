//
//  ATTableViewCell.m
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATTableViewCell.h"

@interface ATTableViewCell () <UIGestureRecognizerDelegate>

@property (nonatomic,strong) UILabel* name;
@property (nonatomic,strong) UILabel* author;

@end

@implementation ATTableViewCell

- (instancetype)initWithReuseID:(NSString*)reuseID {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _objectImageView = [[UIImageView alloc] init];
        self.objectImageView.backgroundColor = [UIColor lightGrayColor];
        UITapGestureRecognizer* tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToImage:)];
        tapGest.delegate = self;
        [self.objectImageView setUserInteractionEnabled:YES];
        [self.objectImageView addGestureRecognizer:tapGest];
        
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.author];
        [self.contentView addSubview:self.objectImageView];
    }
    return self;
}

#pragma mark - Lazy Loading

#define FONT_HELVETICA_LIGHT(s) [UIFont fontWithName:@"HelveticaNeue-Light" size:s]

-(UILabel*)name{
    if (_name == nil) {
        _name = [[UILabel alloc] init];
        _name.font = FONT_HELVETICA_LIGHT(16.0);
    }
    return _name;
}

-(UILabel*)author{
    if (_author == nil) {
        _author = [[UILabel alloc] init];
        _author.font = FONT_HELVETICA_LIGHT(14.0);
    }
    return _author;
}

#pragma mark - Setter

- (void)setSearchResultViewModel:(ATSearchResultViewModel *)searchResultViewModel{
    if (_searchResultViewModel == searchResultViewModel) {
        return;
    }
    _searchResultViewModel = searchResultViewModel;
    [self updateSubViews];
    [self setNeedsLayout];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.searchResultViewModel.cellType == ATCellTypeLeft) {
        self.objectImageView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        self.name.frame = CGRectMake(15 + CGRectGetMaxX(self.objectImageView.frame), 0, self.bounds.size.width - CGRectGetWidth(self.objectImageView.bounds) -  15, 21);
        self.author.frame = CGRectMake(15 + CGRectGetMaxX(self.objectImageView.frame), CGRectGetMaxY(self.name.frame), self.bounds.size.width - CGRectGetWidth(self.objectImageView.bounds) - 15, 21);
    }
    else {
        self.objectImageView.frame = CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
        self.name.frame = CGRectMake(15, 0, self.bounds.size.width - CGRectGetWidth(self.objectImageView.frame) -  15, 21);
        self.author.frame = CGRectMake(15, CGRectGetMaxY(self.name.frame), self.bounds.size.width - CGRectGetWidth(self.objectImageView.frame) - 15, 21);
    }
}

-(void)updateSubViews{
    self.name.text = self.searchResultViewModel.name;
    self.author.text = self.searchResultViewModel.author;
    self.objectImageView.image = [UIImage imageNamed:@""];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imgData = [NSData dataWithContentsOfURL:weakSelf.searchResultViewModel.previewImageUrl];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.objectImageView.image = image;
                });
            }
        }
    });
}

-(void)tapToImage:(UITapGestureRecognizer*)tapGesture{
    [self.delegate userDidTouch:tapGesture imageURL:self.searchResultViewModel.previewImageUrl cell:self];
}

@end
