//
//  TimerViewController.h
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import <UIKit/UIKit.h>
#import "ModalViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TimerViewControllerDelegate <NSObject>

-(void)saveButtonClickedWithTimerValue:(float)timerValue;

@end

@interface TimerViewController : ModalViewController

@property (nonatomic, weak) id<TimerViewControllerDelegate> delegate;

- (instancetype)initWithTimerValue:(float)timerValue;

@end

NS_ASSUME_NONNULL_END
