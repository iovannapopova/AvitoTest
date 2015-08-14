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

@property (nonatomic,assign) CGPoint center;

@end

@implementation ATAnimatedTransitioningObject

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    switch (self.type) {
        case ATAnimationTypePresent:{
            UIView *contextView = [transitionContext containerView];
            [contextView addSubview:toVC.view];
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                self.center = toVC.view.center;
                toVC.view.center = fromVC.view.center;
                CGFloat alpha = fromVC.view.frame.size.width / toVC.view.frame.size.width;
                CGAffineTransform transform = CGAffineTransformMakeScale(alpha, alpha);
                toVC.view.transform = transform;
            }completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        }
            
            break;
            
        case ATAnimationTypeDismiss:{
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                fromVC.view.transform = CGAffineTransformIdentity;
                fromVC.view.center = self.center;
            }completion:^(BOOL finished) {
                [fromVC.view removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
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
