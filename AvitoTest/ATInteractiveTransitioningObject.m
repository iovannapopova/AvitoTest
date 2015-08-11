//
//  ATInteractiveTransitioningObject.m
//  AvitoTest
//
//  Created by Iovanna Popova on 07.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATInteractiveTransitioningObject.h"

@implementation ATInteractiveTransitioningObject

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *contextView = [transitionContext containerView];
    [contextView addSubview:toVC.view];
    
    switch (self.type) {
        case ATAnimationTypePresent:{
            
            [UIView animateWithDuration:[self completionSpeed] animations:^{
                toVC.view.center = fromVC.view.center;
                CGFloat alpha = fromVC.view.frame.size.width / toVC.view.frame.size.width;
                CGAffineTransform transform = CGAffineTransformMakeScale(alpha, alpha);
                toVC.view.transform = transform;
            }completion:^(BOOL finished) {
                UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
                [toVC.view addGestureRecognizer:gestureRecognizer];
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

- (CGFloat)completionSpeed{
    return 0.5;
}

- (UIViewAnimationCurve)completionCurve{
    return UIViewAnimationCurveEaseIn;
}

-(void)handlePinch:(UIPinchGestureRecognizer *)pinch{
    
}

@end
