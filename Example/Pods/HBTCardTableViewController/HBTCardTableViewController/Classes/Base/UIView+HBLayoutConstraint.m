//
//  UIView+HBAutoLayout.m
//  Huoban
//
//  Created by zhoubo on 16/4/19.
//  Copyright © 2016年 huoban. All rights reserved.
//

#import "UIView+HBLayoutConstraint.h"

@implementation UIView (HBLayoutConstraint)

- (void)_addConstraint:(NSLayoutConstraint *)constraint toView:(UIView *)view {
    if ([self.superview isEqual:view]) {
        [view addConstraint:constraint];
    } else if ([self.superview isEqual:view.superview]) {
        [self.superview addConstraint:constraint];
    } else {
        NSAssert(NO, @"the view should not add constraint to view:%@", view);
    }
}

- (NSLayoutConstraint *)hblc_top:(CGFloat)constant toView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.f constant:constant];
    [self _addConstraint:constraint toView:view];
    return constraint;
}

- (NSLayoutConstraint *)hblc_topMargin:(CGFloat)constant toView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTopMargin multiplier:1.f constant:constant];
    [self _addConstraint:constraint toView:view];
    return constraint;
}

- (NSLayoutConstraint *)hblc_left:(CGFloat)constant toView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.f constant:constant];
    [self _addConstraint:constraint toView:view];
    return constraint;
}

- (NSLayoutConstraint *)hblc_leftMargin:(CGFloat)constant toView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeadingMargin multiplier:1.f constant:constant];
    [self _addConstraint:constraint toView:view];
    return constraint;
}

- (NSLayoutConstraint *)hblc_bottom:(CGFloat)constant toView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:constant];
    [self _addConstraint:constraint toView:view];
    return constraint;
}

- (NSLayoutConstraint *)hblc_bottomMargin:(CGFloat)constant toView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:constant];
    [self _addConstraint:constraint toView:view];
    return constraint;
}

- (NSLayoutConstraint *)hblc_right:(CGFloat)constant toView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.f constant:constant];
    [self _addConstraint:constraint toView:view];
    return constraint;
}

- (NSLayoutConstraint *)hblc_rightMargin:(CGFloat)constant toView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.f constant:constant];
    [self _addConstraint:constraint toView:view];
    return constraint;
}

- (NSArray *)hblc_top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right toView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.f constant:top];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.f constant:left];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:bottom];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.f constant:right];
    NSArray *constraints = @[topConstraint, leftConstraint, bottomConstraint, rightConstraint];
    [view addConstraints:constraints];
    return constraints;
}

- (NSLayoutConstraint *)hblc_centerX:(CGFloat)constant toView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:constant];
    [self _addConstraint:constraint toView:view];
    return constraint;
}

- (NSLayoutConstraint *)hblc_centerY:(CGFloat)constant toView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.f constant:constant];
    [self _addConstraint:constraint toView:view];
    return constraint;
}

- (NSLayoutConstraint *)hblc_width:(CGFloat)constant {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:constant];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)hblc_height:(CGFloat)constant {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:constant];
    [self addConstraint:constraint];
    return constraint;
}

@end
