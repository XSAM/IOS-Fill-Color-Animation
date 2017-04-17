//
//  BSXUIView.h
//  BSXMaterialAnimation
//
//  Created by BangshengXie on 16/04/2017.
//  Copyright © 2017 BangshengXie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSXUIView : UIView

- (id)initWithUIView:(UIView*)uiView;
- (Boolean)animateWithCGPoint:(CGPoint)centerPoint
              backgroundColor:(UIColor*)backgroundColor
                     isExpand:(Boolean)isExpand
                     duration:(NSTimeInterval)duration
               timingFunction:(CAMediaTimingFunction*)timingFunction
                   completion:(void (^)(void))completion;

@end
