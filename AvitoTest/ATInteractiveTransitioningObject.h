//
//  ATInteractiveTransitioningObject.h
//  AvitoTest
//
//  Created by Iovanna Popova on 07.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ATInteractiveTransitioningObject : NSObject <UIViewControllerInteractiveTransitioning,UIViewControllerAnimatedTransitioning>

@property (nonatomic, readonly) CGFloat duration;
@property (readonly) CGFloat percentComplete;

@end
