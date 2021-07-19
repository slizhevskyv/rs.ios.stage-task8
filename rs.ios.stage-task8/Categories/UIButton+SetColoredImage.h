//
//  UIButton+SetBackgroundColor.h
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SetColoredImage)

-(void)setColoredImage:(UIColor *)color withWidth:(CGFloat)width height:(CGFloat)height forState:(UIControlState)state;
-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
