//
//  UIButton+SetBackgroundColor.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import "UIButton+SetColoredImage.h"

@implementation UIButton (SetColoredImage)

- (void)setColoredImage:(UIColor *)color withWidth:(CGFloat)width height:(CGFloat)height forState:(UIControlState)state {
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height));
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setImage:coloredImage forState:state];
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, 1, 1));
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:coloredImage forState:state];
}

@end
