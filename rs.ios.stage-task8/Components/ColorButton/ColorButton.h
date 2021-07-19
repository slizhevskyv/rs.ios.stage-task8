//
//  ColorButton.h
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorButton : UIButton

@property (nonatomic, strong, readonly) UIColor *color;

+ (ColorButton *)withColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
