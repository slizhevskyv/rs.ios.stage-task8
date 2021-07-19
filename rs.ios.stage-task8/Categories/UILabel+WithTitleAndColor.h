//
//  UILabel+WithTitleAndColor.h
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/16/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (WithTitleAndColor)

+ (instancetype)getLabelWithTitle:(NSString *)title;
+ (instancetype)getLabelWithTitle:(NSString *)title andColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
