//
//  ATAnimatedTransitioningObject.m
//  AvitoTest
//
//  Created by Iovanna Popova on 08.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATAnimatedTransitioningObject.h"
#import "ATTransitioningDelegateObject.h"
#import "ATImageViewController.h"

@interface ATAnimatedTransitioningObject ()

@property (nonatomic, strong) UITapGestureRecognizer* gesture;

@end
@implementation ATAnimatedTransitioningObject

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *contextView = [transitionContext containerView];
    [contextView addSubview:toVC.view];
    
    switch (self.type) {
        case ATAnimationTypePresent:{
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                toVC.view.center = fromVC.view.center;
                CGFloat alpha = fromVC.view.frame.size.width / toVC.view.frame.size.width;
                CGAffineTransform transform = CGAffineTransformMakeScale(alpha, alpha);
                toVC.view.transform = transform;
            }completion:^(BOOL finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
            
            break;
            
        case ATAnimationTypeDismiss:{

        }
            break;
            
        default:
            break;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

@end
