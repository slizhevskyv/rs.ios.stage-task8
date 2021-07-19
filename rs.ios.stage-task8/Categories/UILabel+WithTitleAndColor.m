//
//  UILabel+WithTitleAndColor.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/16/21.
//

#import "UILabel+WithTitleAndColor.h"

@implementation UILabel (WithTitleAndColor)

+ (instancetype)getLabelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    
    return label;
}

+ (instancetype)getLabelWithTitle:(NSString *)title andColor:(UIColor *)color {
    UILabel *label = [UILabel getLabelWithTitle:title];
    label.textColor = color;
    
    return label;
}

@end
