//
//  Canvas.h
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Canvas : UIView

@property (nonatomic, strong) NSArray<UIColor *> *colors;
@property (nonatomic, copy) NSString *templateName;
@property (nonatomic, assign) BOOL isReadyToDraw;
@property (nonatomic, assign) BOOL reset;

-(UIImage *)takeSnapshot;
-(void) drawWithInterval:(double) interval andCallback:(void (^)(void)) callback;

@end

NS_ASSUME_NONNULL_END
