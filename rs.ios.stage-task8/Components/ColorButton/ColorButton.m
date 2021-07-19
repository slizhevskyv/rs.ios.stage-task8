//
//  ColorButton.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import "ColorButton.h"
#import "UIButton+SetColoredImage.h"

@interface ColorButton ()

@property (nonatomic, strong, readwrite) UIColor *color;

@end

@implementation ColorButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupAppearance];
    }
    return self;
}

+ (ColorButton *)withColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height {
    ColorButton *colorButton = [ColorButton new];
    [colorButton setColoredImage:color withWidth:width height:height forState:UIControlStateNormal];
    
    colorButton.color = color;
    
    return colorButton;
}

- (void)setupAppearance {
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = 10;
    
    self.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.25].CGColor;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 1;
    
    self.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    
    self.imageView.layer.cornerRadius = 6;
    
    self.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected: selected];
    
    if (selected) {
        [self setBackgroundColor:self.color forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

@end
