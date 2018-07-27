//
//  UIView+HBAnimation.h
//  Huoban
//
//  Created by zhoubo on 15/6/6.
//  Copyright (c) 2015年 huoban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HBAnimation)

- (void)hb_setHidden:(BOOL)hide withAnimatedDuration:(NSTimeInterval)duration;

- (void)hb_playRotateForKey:(NSString *)key duration:(NSTimeInterval)duration rotations:(CGFloat)rotations repeat:(BOOL)repeat completion:(void (^)(void))completion;

- (void)hb_stopAnimationWithKey:(NSString *)key;

- (void)hb_startAnimatingActivityIndicatorWithCenterX:(CGFloat)centerX centerY:(CGFloat)centerY;
- (void)hb_stopAnimatingActivityIndicator;

- (void)hb_alphaAnimateWithDuration:(NSTimeInterval)duration toValue:(CGFloat)toValue;

@end
