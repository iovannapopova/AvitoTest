//
//  ATInteractiveTransitioningObject.m
//  AvitoTest
//
//  Created by Iovanna Popova on 07.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATInteractiveTransitioningObject.h"
#import "ATImageViewController.h"

@interface ATInteractiveTransitioningObject ()

@property (nonatomic, strong) UIViewController* fromVC;
@property (nonatomic, strong) UIViewController* toVC;
@property (nonatomic, strong) UIView* containerView;
@property (nonatomic, strong) UIView* transitioningView;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) CGAffineTransform startTransform;
@property (nonatomic, assign) CGPoint startCenter;
@property (nonatomic, assign) CGPoint endCenter;

@end

@implementation ATInteractiveTransitioningObject

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView = [transitionContext containerView];
    self.transitionContext = transitionContext;
    self.startTransform = self.fromVC.view.transform;
    self.startCenter = self.fromVC.view.center;
    self.endCenter = [(ATTransitioningDelegateObject*)self.fromVC.transitioningDelegate startCenter];
}

- (CGFloat)completionSpeed{
    return 0.5;
}

- (UIViewAnimationCurve)completionCurve{
    return UIViewAnimationCurveEaseIn;
}

#pragma mark - Gesture


- (void)handlePinch:(UIPinchGestureRecognizer*)gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
            
        case UIGestureRecognizerStateChanged: {
            static const CGFloat startScale = 1.0;
            static const CGFloat endScale = 0.25;
            self.alpha = (gesture.scale - startScale) / (endScale - startScale);
            self.alpha = MAX(self.alpha, 0);
            self.alpha = MIN(self.alpha, 1);
            
            CGAffineTransform transform = self.fromVC.view.transform;
            transform.a = [self interpolationStart:self.startTransform.a end:CGAffineTransformIdentity.a alpha:self.alpha];
            transform.d = [self interpolationStart:self.startTransform.d end:CGAffineTransformIdentity.d alpha:self.alpha];
            
            self.fromVC.view.transform = transform;
            
            CGPoint center = self.fromVC.view.center;
            
            center.x = [self interpolationStart:self.startCenter.x end:self.endCenter.x alpha:self.alpha];
            center.y = [self interpolationStart:self.startCenter.y end:self.endCenter.y alpha:self.alpha];
            
            self.fromVC.view.center = center;
            
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled: {
            [self continueAnimation:(self.alpha > 0.2)];
        }
            break;
            
        default:
            break;
    }
}

-(void)continueAnimation:(BOOL)finished {
    if (finished) {
        [UIView animateWithDuration:[self completionSpeed] animations:^{
            self.fromVC.view.transform = CGAffineTransformIdentity;
            self.fromVC.view.center = self.endCenter;
        } completion:^(BOOL finished) {
            [self.transitionContext finishInteractiveTransition];
            [self.transitionContext completeTransition:YES];
        }];
    } else {
        [UIView animateWithDuration:[self completionSpeed] animations:^{
            self.fromVC.view.transform = self.startTransform;
            self.fromVC.view.center = self.startCenter;
        } completion:^(BOOL finished) {
            [self.transitionContext cancelInteractiveTransition];
            [self.transitionContext completeTransition:NO];
        }];
    }
}


- (CGFloat)interpolationStart:(CGFloat)startValue end:(CGFloat)endValue alpha:(CGFloat)alpha{
    return startValue + alpha * (endValue - startValue);
}


@end
