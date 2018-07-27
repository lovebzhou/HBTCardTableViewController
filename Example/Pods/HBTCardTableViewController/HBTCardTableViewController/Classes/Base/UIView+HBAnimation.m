//
//  UIView+HBAnimation.m
//  Huoban
//
//  Created by zhoubo on 15/6/6.
//  Copyright (c) 2015年 huoban. All rights reserved.
//

#import "UIView+HBAnimation.h"
#import "UIView+HBLayoutConstraint.h"

@implementation UIView (HBAnimation)

-(void)hb_setHidden:(BOOL)hide withAnimatedDuration:(NSTimeInterval)duration {
    if(self.hidden == hide)
        return;
    if(hide)
        self.alpha = 1;
    else {
        self.alpha = 0;
        self.hidden = NO;
    }
    [UIView animateWithDuration:duration animations:^{
        if (hide)
            self.alpha = 0;
        else
            self.alpha = 1;
    } completion:^(BOOL finished) {
        if(finished)
            self.hidden = hide;
    }];
}

- (void)hb_playRotateForKey:(NSString *)key duration:(NSTimeInterval)duration rotations:(CGFloat)rotations repeat:(BOOL)repeat completion:(void (^)(void))completion {
    [CATransaction begin];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * rotations];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.repeatCount = repeat ? HUGE_VALF : 0;
    
    [CATransaction setCompletionBlock:completion];
    [self.layer addAnimation:rotationAnimation forKey:key];
    [CATransaction commit];
}

- (void)hb_stopAnimationWithKey:(NSString *)key {
    [self.layer removeAnimationForKey:key];
}

- (void)hb_startAnimatingActivityIndicatorWithCenterX:(CGFloat)centerX centerY:(CGFloat)centerY {
    UIActivityIndicatorView *aiv = [self viewWithTag:20170911];
    if (aiv == nil) {
        aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:aiv];
        aiv.tag = 20170911;
        aiv.hidesWhenStopped = YES;
        [aiv hblc_width:20];
        [aiv hblc_height:20];
        [aiv hblc_centerX:centerX toView:self];
        [aiv hblc_centerY:centerY toView:self];
    }
    
    [aiv startAnimating];
}

- (void)hb_stopAnimatingActivityIndicator {
    UIActivityIndicatorView *aiv = [self viewWithTag:20170911];
    [aiv stopAnimating];
}

- (void)hb_alphaAnimateWithDuration:(NSTimeInterval)duration toValue:(CGFloat)toValue {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [self setAlpha:toValue];
    [UIView commitAnimations];
}

@end
