//
//  ATImageViewController.m
//  AvitoTest
//
//  Created by Iovanna Popova on 07.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATImageViewController.h"


@implementation ATImageViewController


- (instancetype)initWithImageView:(UIImageView*)imageView{
    self = [super init];
    if (self) {
        _imageView = imageView;
        _imageView.userInteractionEnabled = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.imageView.center = CGPointMake(CGRectGetMidX(self.view.bounds),CGRectGetMidY(self.view.bounds));
}


@end
