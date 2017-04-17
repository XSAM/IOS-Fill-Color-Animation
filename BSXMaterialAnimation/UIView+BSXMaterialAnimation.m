//
//  UIView+BSXMaterialAnimation.m
//  BSXMaterialAnimation
//
//  Created by BangshengXie on 16/04/2017.
//  Copyright © 2017 BangshengXie. All rights reserved.
//

#import "UIView+BSXMaterialAnimation.h"

@implementation UIView (BSXMaterialAnimation)

NSInteger const BSXAnimationViewTag = 927;

- (void)setupForBSXAnimation
{
    BSXUIView *animationView = [[BSXUIView alloc] initWithUIView:self];
    animationView.tag = BSXAnimationViewTag;
}

- (Boolean)runBSXAnimateWithCGPoint:(CGPoint)centerPoint
                    backgroundColor:(UIColor*)backgroundColor
                           isExpand:(Boolean)isExpand
                           duration:(NSTimeInterval)duration
                     timingFunction:(CAMediaTimingFunction*)timingFunction
                         completion:(void (^)(void))completion
{
    BSXUIView *animationView = (BSXUIView*)[self viewWithTag:BSXAnimationViewTag];
    return [animationView animateWithCGPoint:centerPoint
                             backgroundColor:backgroundColor
                                    isExpand:isExpand
                                    duration:duration
                              timingFunction:timingFunction
                                  completion:completion];
}

@end
