//
//  ModalPresentationController.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import "ModalPresentationController.h"

@implementation ModalPresentationController

- (CGRect)frameOfPresentedViewInContainerView {
    CGRect parentVCRect = self.presentingViewController.view.frame;
    CGRect frame = CGRectMake(0, parentVCRect.size.height / 2, parentVCRect.size.width, parentVCRect.size.height / 2);
    
    return frame;
}

@end
