//
//  DrawingsViewController.h
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/17/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DrawingsViewControllerDelegate <NSObject>

- (void)currentDrawingDidChange:(NSString *)currentDrawing;

@end

@interface DrawingsViewController : UIViewController

@property (nonatomic, weak) id<DrawingsViewControllerDelegate> delegate;

- (instancetype)initWithDrawings:(NSArray<NSString *> *)drawings andCurrentDrawing: (NSString * _Nullable ) currentDrawing;

@end

NS_ASSUME_NONNULL_END
