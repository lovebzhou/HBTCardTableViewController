//
//  UIView+HBAutoLayout.h
//  Huoban
//
//  Created by zhoubo on 16/4/19.
//  Copyright © 2016年 huoban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HBLayoutConstraint)

- (NSLayoutConstraint *)hblc_top:(CGFloat)constant toView:(UIView *)view;
- (NSLayoutConstraint *)hblc_topMargin:(CGFloat)constant toView:(UIView *)view;

- (NSLayoutConstraint *)hblc_left:(CGFloat)constant toView:(UIView *)view;
- (NSLayoutConstraint *)hblc_leftMargin:(CGFloat)constant toView:(UIView *)view;

- (NSLayoutConstraint *)hblc_bottom:(CGFloat)constant toView:(UIView *)view;
- (NSLayoutConstraint *)hblc_bottomMargin:(CGFloat)constant toView:(UIView *)view;

- (NSLayoutConstraint *)hblc_right:(CGFloat)constant toView:(UIView *)view;
- (NSLayoutConstraint *)hblc_rightMargin:(CGFloat)constant toView:(UIView *)view;

- (NSArray *)hblc_top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right toView:(UIView *)view;

- (NSLayoutConstraint *)hblc_centerX:(CGFloat)constant toView:(UIView *)view;
- (NSLayoutConstraint *)hblc_centerY:(CGFloat)constant toView:(UIView *)view;
- (NSLayoutConstraint *)hblc_width:(CGFloat)constant;
- (NSLayoutConstraint *)hblc_height:(CGFloat)constant;

@end
