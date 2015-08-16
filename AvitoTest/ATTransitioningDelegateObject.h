//
//  ATTransitioningDelegateObject.h
//  AvitoTest
//
//  Created by Iovanna Popova on 08.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ATAnimationType){
    ATAnimationTypePresent,
    ATAnimationTypeDismiss
};

@interface ATTransitioningDelegateObject : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) ATAnimationType type;
@property (nonatomic, assign) BOOL interactive;
@property (nonatomic, assign) CGPoint startCenter;

- (void)handlePinch:(UIPinchGestureRecognizer*)gesture;

@end
