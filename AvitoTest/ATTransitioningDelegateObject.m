//
//  ATTransitioningDelegateObject.m
//  AvitoTest
//
//  Created by Iovanna Popova on 08.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATTransitioningDelegateObject.h"
#import "ATAnimatedTransitioningObject.h"
#import "ATInteractiveTransitioningObject.h"

@interface ATTransitioningDelegateObject ()

@property (nonatomic, strong) ATInteractiveTransitioningObject *interactive;
@property (nonatomic, strong) ATAnimatedTransitioningObject *animated;


@end

@implementation ATTransitioningDelegateObject

#pragma mark - Lazy loading

- (ATAnimatedTransitioningObject*)animated{
    if (_animated == nil) {
        _animated = [[ATAnimatedTransitioningObject alloc] init];
    }
    return _animated;
}

- (ATInteractiveTransitioningObject*)interactive{
    if (_interactive == nil) {
        _interactive = [[ATInteractiveTransitioningObject alloc] init];
    }
    return _interactive;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.animated;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.animated;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.interactive;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.interactive;
}

@end
