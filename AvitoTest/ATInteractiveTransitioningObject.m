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
    CGFloat distanceBetweenCenters;
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
    [self.containerView addSubview:self.toVC.view];
    
    self.toVC.view.frame = [transitionContext finalFrameForViewController:self.toVC];
    [self.containerView insertSubview:self.toVC.view belowSubview:self.fromVC.view];
    
    self.transitioningView = self.fromVC.view;
    self.transitionContext = transitionContext;
}

- (CGFloat)completionSpeed{
    return 0.5;
}

- (UIViewAnimationCurve)completionCurve{
    return UIViewAnimationCurveEaseIn;
}

-(void)updateWithPercent:(CGFloat)percent {
    CGFloat scale = fabs(percent-1.0);
    self.fromVC.view.transform =  CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
    //[self.transitionContext updateInteractiveTransition:percent];
}

- (void)handlePan:(UIPanGestureRecognizer*)gesture{
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            //distance is ok
            CGPoint translation = [gesture translationInView:[(ATImageViewController*)self.fromVC imageView]];
            gesture.view.center = CGPointMake(gesture.view.center.x + translation.x,
                                              gesture.view.center.y + translation.y);
            [gesture setTranslation:CGPointZero inView:[(ATImageViewController*)self.fromVC imageView]];
            
//            CGPoint centerToVC = [(ATImageViewController*)self.fromVC fromCenter];
//            CGPoint centerFromVC = CGPointMake(160, 284);
//            CGPoint center = self.fromVC.view.center;
//            distanceBetweenCenters = sqrtf((centerToVC.x - centerFromVC.x)*(centerToVC.x - centerFromVC.x) + (centerToVC.y - centerFromVC.y)*(centerToVC.y - centerFromVC.y));
//            //CGPoint finger = CGPointMake(translation.x, translation.y);
//            
//            CGFloat changingDistanceBetweenCenters = sqrtf((centerToVC.x - center.x)*(centerToVC.x - center.x) + (centerToVC.y - center.y)*(centerToVC.y - center.y));
////            CGFloat distanceBetWeenFingerAndCenter = sqrtf((finger.x - centerToVC.x)*(finger.x - centerToVC.x) + (finger.y - centerToVC.y)*(finger.y - centerToVC.y));
////            CGFloat distanceFinger = sqrtf((finger.x)*(finger.x) + (finger.y)*(finger.y));
//            
//            CGFloat percent = changingDistanceBetweenCenters / distanceBetweenCenters;
//            [self updateWithPercent:percent];
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
//            [self.fromVC.view removeFromSuperview];
//            [self.transitionContext finishInteractiveTransition];
//            [self.transitionContext completeTransition:YES];
            break;
        }
        case UIGestureRecognizerStateCancelled: {
//            [self.transitionContext cancelInteractiveTransition];
//            [self.transitionContext completeTransition:YES];
            break;
        }
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateFailed:
            break;
    }
}

@end
