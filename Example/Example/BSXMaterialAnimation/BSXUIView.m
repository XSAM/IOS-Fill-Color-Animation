//
//  BSXUIView.m
//  BSXMaterialAnimation
//
//  Created by BangshengXie on 16/04/2017.
//  Copyright © 2017 BangshengXie. All rights reserved.
//

#import "BSXUIView.h"

@interface BSXUIView()

@property (assign, nonatomic) Boolean isAnimating;
@property (strong, nonatomic) CAShapeLayer *maskLayer;
@property (strong, nonatomic) CABasicAnimation *pathAnimation;
@property (strong, nonatomic) NSTimer *animationCompleted;
@property (assign, nonatomic) CGFloat MaxDiameter;

- (UIBezierPath*)pathWithCGPoint:(CGPoint)centerPoint
                        Diameter:(CGFloat)diameter;

- (CGFloat)getMaxDiameterWithCGPoint:(CGPoint)centerPoint;

@end

@implementation BSXUIView

#pragma mark - lazy instantiation

- (CAShapeLayer*)maskLayer
{
    if(!_maskLayer)
    {
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        _maskLayer = maskLayer;
        return _maskLayer;
    }
    return _maskLayer;
}

#pragma mark - setup

- (id)initWithUIView:(UIView*)uiView
{
    self = [super initWithFrame:uiView.bounds];
    if(self)
    {
        //add BSXUIView to show animation
        [uiView addSubview:self];
        //retain uiView origin view structure order
        [uiView sendSubviewToBack:self];

        self.isAnimating = false;
        self.layer.mask = self.maskLayer;
    }
    return self;
}

#pragma mark - animation

- (Boolean)animateWithCGPoint:(CGPoint)centerPoint
              backgroundColor:(UIColor*)backgroundColor
                     isExpand:(Boolean)isExpand
                     duration:(NSTimeInterval)duration
               timingFunction:(CAMediaTimingFunction*)timingFunction
                   completion:(void (^)(void))completion
{
    if(!self.isAnimating)
    {
        self.isAnimating = true;
        //ensure BSXUIView cover superview
        self.frame = self.superview.bounds;
        
        [self.maskLayer setHidden:false];
        self.MaxDiameter = [self getMaxDiameterWithCGPoint:centerPoint];
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        
        UIBezierPath *maxPath = [self pathWithCGPoint:centerPoint
                                             Diameter:self.MaxDiameter];
        UIBezierPath *minPath = [self pathWithCGPoint:centerPoint
                                             Diameter:0];
        
        if(timingFunction)
            pathAnimation.timingFunction = timingFunction;
        else
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        //whether require expand animation
        if(isExpand)
        {
            pathAnimation.fromValue = (id)[minPath CGPath];
            pathAnimation.toValue = (id)[maxPath CGPath];
            self.backgroundColor = backgroundColor;
        }
        else
        {
            pathAnimation.fromValue = (id)[maxPath CGPath];
            pathAnimation.toValue = (id)[minPath CGPath];
            self.backgroundColor = self.superview.backgroundColor;
            self.superview.backgroundColor = backgroundColor;
            
        }
        pathAnimation.duration = duration;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        [self.maskLayer addAnimation:pathAnimation forKey:nil];
        
        //animationCompleted can be called only once
        [self.animationCompleted invalidate];
        self.animationCompleted = [NSTimer scheduledTimerWithTimeInterval:duration
                                                                  repeats:false
                                                                    block:^(NSTimer * _Nonnull timer) {
                                                                        //exchange uiView and BSXUIView color when expand animation completed
                                                                        if(isExpand)
                                                                        {
                                                                            
                                                                            UIColor *color = self.superview.backgroundColor;
                                                                            self.superview.backgroundColor = self.backgroundColor;
                                                                            self.backgroundColor = color;
                                                                        }
                                                                        
                                                                        self.isAnimating = false;
                                                                        [self.maskLayer setHidden:true];
                                                                        if(completion)
                                                                        {
                                                                            completion();
                                                                        }
                                                                    }];
        return true;
    }
    else
    {
        return false;
    }
}

#pragma mark - generic method

//calculate the max distance amount uiview corner points
- (CGFloat)getMaxDiameterWithCGPoint:(CGPoint)centerPoint
{
    CGSize size = self.superview.bounds.size;
    CGFloat x,y;
    
    x = centerPoint.x >= size.width/2 ? centerPoint.x : size.width - centerPoint.x;
    y = centerPoint.y >= size.height/2 ? centerPoint.y : size.height - centerPoint.y;
    
    return sqrt(pow(x, 2) + pow(y, 2))*2;
}

- (UIBezierPath*)pathWithCGPoint:(CGPoint)centerPoint
                        Diameter:(CGFloat)diameter
{
    return [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerPoint.x-(diameter/2) , centerPoint.y - (diameter/2), diameter, diameter)];
}


@end
