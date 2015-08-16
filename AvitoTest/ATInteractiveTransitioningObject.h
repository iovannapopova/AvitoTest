//
//  ATInteractiveTransitioningObject.h
//  AvitoTest
//
//  Created by Iovanna Popova on 07.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ATTransitioningDelegateObject.h"

@interface ATInteractiveTransitioningObject : NSObject <UIViewControllerInteractiveTransitioning>

@property (nonatomic, readonly) CGFloat duration;
@property (readonly) CGFloat percentComplete;
@property (nonatomic, assign) ATAnimationType type;

- (void)handlePinch:(UIPinchGestureRecognizer*)gesture;

@end
