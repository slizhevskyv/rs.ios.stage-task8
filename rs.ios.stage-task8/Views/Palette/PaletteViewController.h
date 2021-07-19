//
//  PaletteViewController.h
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import <UIKit/UIKit.h>
#import "ModalViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PaletteViewControllerDelegate <NSObject>

- (void)saveButtonClickedWithColors:(NSMutableArray<UIColor *> *)currentColors;

@end

@interface PaletteViewController : ModalViewController

@property (nonatomic, weak) id<PaletteViewControllerDelegate> delegate;

-(instancetype)initWithPaletteColors:(NSMutableArray<UIColor *> *)paletteColors;

@end

NS_ASSUME_NONNULL_END
