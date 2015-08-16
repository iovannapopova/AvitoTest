//
//  ATImageViewController.h
//  AvitoTest
//
//  Created by Iovanna Popova on 07.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATImageViewController : UIViewController 

- (instancetype)initWithImage:(UIImage*)image;

@property (nonatomic, readonly) UIImageView* imageView;

@end
