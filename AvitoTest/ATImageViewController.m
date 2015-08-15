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
        UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [_imageView addGestureRecognizer:panGesture];
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

- (void)handlePan:(UIPanGestureRecognizer*)gesture{
    [(ATTransitioningDelegateObject*)self.transitioningDelegate handlePan:(UIPanGestureRecognizer*)gesture];
    [(ATTransitioningDelegateObject*)self.transitioningDelegate setInteractive:YES];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self setTransitioningDelegate:nil];
        }];
    }
}

@end
