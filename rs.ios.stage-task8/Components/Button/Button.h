//
//  Button.h
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/16/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Button : UIButton

+ (Button *)buttonWithTitle:(NSString *)title handler:(SEL)handler andEnableStatus:(BOOL)isEnabled;

@end

NS_ASSUME_NONNULL_END
