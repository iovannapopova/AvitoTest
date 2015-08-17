//
//  ATImageViewController.m
//  AvitoTest
//
//  Created by Iovanna Popova on 07.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATImageViewController.h"
#import "ATTransitioningDelegateObject.h"

@interface ATImageViewController ()

@property (nonatomic, strong) UIImage* image;

@end


@implementation ATImageViewController

- (instancetype)initWithImage:(UIImage*)image{
    self = [super init];
    if (self) {
        _image = image;
        _imageView = [[UIImageView alloc] initWithImage:_image];
        _imageView.userInteractionEnabled = YES;
        
        UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        [_imageView addGestureRecognizer:pinchGesture];
        
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_imageView addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width);
    self.imageView.center = CGPointMake(CGRectGetMidX(self.view.bounds),CGRectGetMidY(self.view.bounds));
}

- (void)handlePinch:(UIPinchGestureRecognizer*)gesture{
    [(ATTransitioningDelegateObject*)self.transitioningDelegate setInteractive:YES];
    [(ATTransitioningDelegateObject*)self.transitioningDelegate handlePinch:gesture];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)handleTap:(UITapGestureRecognizer*)gesture{
    [(ATTransitioningDelegateObject*)self.transitioningDelegate setInteractive:NO];
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
