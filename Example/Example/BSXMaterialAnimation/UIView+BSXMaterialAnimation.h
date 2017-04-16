//
//  UIView+BSXMaterialAnimation.h
//  BSXMaterialAnimation
//
//  Created by BangshengXie on 16/04/2017.
//  Copyright © 2017 BangshengXie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSXUIView.h"

@interface UIView (BSXMaterialAnimation)

- (void)setupForBSXAnimation;

- (Boolean)runBSXAnimateWithCGPoint:(CGPoint)centerPoint
                 backgroundColor:(UIColor*)backgroundColor
                        isExpand:(Boolean)isExpand
                        duration:(NSTimeInterval)duration
                  timingFunction:(CAMediaTimingFunction*)timingFunction
                      completion:(void (^)(void))completion;

@end
