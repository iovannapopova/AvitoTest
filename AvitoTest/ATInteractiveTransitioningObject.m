//
//  ATInteractiveTransitioningObject.m
//  AvitoTest
//
//  Created by Iovanna Popova on 07.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATInteractiveTransitioningObject.h"
#import "ATImageViewController.h"

@implementation ATInteractiveTransitioningObject

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

}

- (CGFloat)completionSpeed{
    return 0.5;
}

- (UIViewAnimationCurve)completionCurve{
    return UIViewAnimationCurveEaseIn;
}


@end
