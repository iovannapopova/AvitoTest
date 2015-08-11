//
//  ATAnimatedTransitioningObject.h
//  AvitoTest
//
//  Created by Iovanna Popova on 08.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ATTransitioningDelegateObject.h"

@interface ATAnimatedTransitioningObject : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) ATAnimationType type;

@end
