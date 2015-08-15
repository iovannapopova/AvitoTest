//
//  ATInteractiveTransitioningObject.m
//  AvitoTest
//
//  Created by Iovanna Popova on 07.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATInteractiveTransitioningObject.h"
#import "ATImageViewController.h"

@interface ATInteractiveTransitioningObject () {
    CGFloat translationY;
    CGPoint center;
}

@property (nonatomic, strong) UIViewController* fromVC;
@property (nonatomic, strong) UIViewController* toVC;
@property (nonatomic, strong) UIView* containerView;
@property (nonatomic, strong) UIView* transitioningView;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation ATInteractiveTransitioningObject

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView = [transitionContext containerView];
    self.transitionContext = transitionContext;
}

- (CGFloat)completionSpeed{
    return 0.5;
}

- (UIViewAnimationCurve)completionCurve{
    return UIViewAnimationCurveEaseIn;
}

- (void)handlePan:(UIPanGestureRecognizer*)gesture{
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [gesture translationInView:self.fromVC.view.superview];
            self.fromVC.view.center = CGPointMake(self.fromVC.view.center.x, self.fromVC.view.center.y + translation.y);
            [gesture setTranslation:CGPointZero inView:self.fromVC.view.superview];
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            [self.fromVC.view removeFromSuperview];
            [self.transitionContext finishInteractiveTransition];
            [self.transitionContext completeTransition:YES];
            break;
        }
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateFailed:
            break;
    }
}

@end
