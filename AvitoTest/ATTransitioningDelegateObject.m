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
#import "ATImageViewController.h"

@interface ATTransitioningDelegateObject ()

@property (nonatomic, strong) ATInteractiveTransitioningObject *interactiveAnimation;
@property (nonatomic, strong) ATAnimatedTransitioningObject *animatedAnimation;


@end

@implementation ATTransitioningDelegateObject

#pragma mark - Lazy loading

- (ATAnimatedTransitioningObject*)animatedAnimation{
    if (_animatedAnimation == nil) {
        _animatedAnimation = [[ATAnimatedTransitioningObject alloc] init];
    }
    return _animatedAnimation;
}

- (ATInteractiveTransitioningObject*)interactiveAnimation{
    if (_interactiveAnimation == nil) {
        _interactiveAnimation = [[ATInteractiveTransitioningObject alloc] init];
    }
    return _interactiveAnimation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.animatedAnimation.type = ATAnimationTypePresent;
    return self.animatedAnimation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.animatedAnimation.type = ATAnimationTypeDismiss;
    return self.animatedAnimation;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (!self.interactive) {
        return nil;
    }
    self.interactiveAnimation.type = ATAnimationTypePresent;
    return self.interactiveAnimation;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (!self.interactive) {
        return nil;
    }
    self.interactiveAnimation.type = ATAnimationTypeDismiss;
    return self.interactiveAnimation;
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture{
    [self.interactiveAnimation handlePan:gesture];
}

@end
