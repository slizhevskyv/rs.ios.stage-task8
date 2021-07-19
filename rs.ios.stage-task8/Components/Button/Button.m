//
//  Button.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/16/21.
//

#import "Button.h"
#import "UIColor+WithPalleteColors.h"

@implementation Button

+ (Button *)buttonWithTitle:(NSString *)title handler:(SEL)handler andEnableStatus:(BOOL)isEnabled {
    Button *button = [Button new];
    
    button.titleLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:18];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGreenSea] forState:UIControlStateNormal];
    
    button.layer.shadowColor = [[UIColor black] colorWithAlphaComponent:0.25].CGColor;
    button.layer.shadowRadius = 1;
    button.layer.shadowOffset = CGSizeZero;
    button.layer.shadowOpacity = 1;
    
    button.layer.cornerRadius = 10;
    button.layer.backgroundColor = [UIColor white].CGColor;
    
    [button sizeToFit];
    button.contentEdgeInsets = UIEdgeInsetsMake(5, 21, 5, 21);
    
    button.enabled = isEnabled;
    
    [button addTarget:nil action:handler forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled: enabled];
    
    self.layer.opacity = enabled ? 1 : 0.5;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted: highlighted];
    
    self.layer.shadowColor = highlighted ? [UIColor lightGreenSea].CGColor : [[UIColor black] colorWithAlphaComponent:0.25].CGColor;
    self.layer.shadowRadius = highlighted ? 2 : 1;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    if (selected) {
        self.layer.shadowColor = [UIColor lightGreenSea].CGColor;
        self.layer.shadowRadius = 2;
    }
}

@end
