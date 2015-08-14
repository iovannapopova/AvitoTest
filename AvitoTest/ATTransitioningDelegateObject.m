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
    self.animated.type = ATAnimationTypePresent;
    return self.animated;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.animated.type = ATAnimationTypeDismiss;
    return self.animated;
}

//- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
//    self.interactive.type = ATAnimationTypePresent;
//    return self.interactive;
//}
//
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    self.interactive.type = ATAnimationTypeDismiss;
    return self.interactive;
}



@end
