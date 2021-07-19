//
//  ArtistViewController.h
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/16/21.
//

#import <UIKit/UIKit.h>
#import "DrawingsViewController.h"
#import "PaletteViewController.h"
#import "TimerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArtistViewController : UIViewController <DrawingsViewControllerDelegate, PaletteViewControllerDelegate, TimerViewControllerDelegate>

@end

NS_ASSUME_NONNULL_END
