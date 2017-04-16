//
//  ViewController.m
//  Example
//
//  Created by BangshengXie on 16/04/2017.
//  Copyright © 2017 BangshengXie. All rights reserved.
//

#import "ViewController.h"
#import "UIView+BSXMaterialAnimation.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *uiview;
@property (weak, nonatomic) IBOutlet UILabel *durationValueLabel;

@property (assign, nonatomic) CGFloat duration;
@property (assign, nonatomic) Boolean isFirst;

-(UIColor*)colorWithHexString:(NSString*)hex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.duration = 0.65f;
    
    //setup
    [self.uiview setupForBSXAnimation];
}

- (IBAction)expand:(id)sender
{
    [self.uiview runBSXAnimateWithCGPoint:CGPointMake(0, 0)
                          backgroundColor:[self randomColor]
                                 isExpand:true
                                 duration:self.duration
                           timingFunction:nil
                               completion:nil];
}

- (IBAction)shrink:(id)sender
{
    [self.uiview runBSXAnimateWithCGPoint:CGPointMake(0, 0)
                          backgroundColor:[self randomColor]
                                 isExpand:false
                                 duration:self.duration
                           timingFunction:nil
                               completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.view];
    NSLog(@"%f %f",currentLocation.x, currentLocation.y);
    
    if(self.isFirst)
    {
        if([self.uiview runBSXAnimateWithCGPoint:currentLocation
                                 backgroundColor:[self colorWithHexString:@"3F51B5"]
                                        isExpand:true
                                        duration:self.duration
                                  timingFunction:nil
                                      completion:nil])
        {
            self.isFirst = false;
        }
        
    }
    else
    {
        if([self.uiview runBSXAnimateWithCGPoint:currentLocation
                                 backgroundColor:[self colorWithHexString:@"03A9F4"]
                                        isExpand:true
                                        duration:self.duration
                                  timingFunction:nil
                                      completion:nil])
        {
            self.isFirst = true;
        }
    }
}

- (IBAction)sliderValueChanged:(UISlider *)sender
{
    self.durationValueLabel.text = [NSString stringWithFormat:@"%0.02f",sender.value];
    self.duration = sender.value;
}


- (UIColor *)randomColor
{
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    NSLog(@"%@", color);
    return color;
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end
