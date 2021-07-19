//
//  PaletteViewController.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import "PaletteViewController.h"
#import "ModalPresentationController.h"
#import "Button.h"
#import "ColorButton.h"

@interface PaletteViewController ()

@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *palette;
@property (nonatomic, strong) NSMutableArray<UIColor *> *currentPaletteColors;
@property (nonatomic, strong) NSMutableArray<ColorButton *> *colorButtons;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PaletteViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _palette = @[
            @[
                @"PaletteColorRed",
                @"PaletteColorBlue",
                @"PaletteColorGreen",
                @"PaletteColorGray",
                @"PaletteColorPurple",
                @"PaletteColorPeach"
            ],
            @[
                @"PaletteColorOrange",
                @"PaletteColorLightBlue",
                @"PaletteColorPink",
                @"PaletteColorHeavyBlue",
                @"PaletteColorHeavyGreen",
                @"PaletteColorBrown",
            ]
        ];
        
        _currentPaletteColors = [NSMutableArray arrayWithArray:@[]];
        
        _colorButtons = [NSMutableArray arrayWithArray:@[]];
    }
    return self;
}

-(instancetype)initWithPaletteColors:(NSMutableArray<UIColor *> *)paletteColors {
    self = [[PaletteViewController alloc] init];
    if(self) {
        _currentPaletteColors = paletteColors;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupPaletteLayout];
    [self updateColorButtonSelectedStatus];
}

-(void)setupPaletteLayout {
    UIStackView *paletteContainer = [UIStackView new];
    paletteContainer.axis = UILayoutConstraintAxisVertical;
    paletteContainer.spacing = 20;
    
    [self.palette enumerateObjectsUsingBlock:^(NSArray<NSString *> *paletteRow, NSUInteger idx, BOOL *stop) {
        UIStackView *row = [UIStackView new];
        row.spacing = 20;
        
        [paletteRow enumerateObjectsUsingBlock:^(NSString *paletteColor, NSUInteger idx, BOOL *stop) {
            ColorButton *colorButton = [ColorButton withColor:[UIColor colorNamed:paletteColor] width:24 height:24];
            
            [colorButton addTarget:self action:@selector(chooseColorHandler:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.colorButtons addObject:colorButton];
            
            [row addArrangedSubview:colorButton];
            
            // MARK: Color Button constraints
            colorButton.translatesAutoresizingMaskIntoConstraints = NO;
            [colorButton.widthAnchor constraintEqualToConstant:40].active = YES;
            [colorButton.heightAnchor constraintEqualToConstant:40].active = YES;
        }];
        
        [paletteContainer addArrangedSubview:row];
    }];
    
    [self.view addSubview:paletteContainer];
    
    // MARK: Palette Container constraints
    paletteContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [paletteContainer.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:92],
        [paletteContainer.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:17],
        [paletteContainer.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-18],
    ]];
}

-(void)updateColorButtonSelectedStatus {
    [self.colorButtons enumerateObjectsUsingBlock:^(ColorButton *colorButton, NSUInteger idx, BOOL *stop) {
        if ([self.currentPaletteColors indexOfObject:colorButton.color] != NSNotFound) {
            [colorButton setSelected:YES];
        } else {
            [colorButton setSelected:NO];
        }
    }];
}

-(void)changeViewBackgroundColorWith:(UIColor *)color {
    self.view.backgroundColor = color;

    [self.timer invalidate];
    
    __weak PaletteViewController *weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:NO block:^(NSTimer *timer) {
        __strong PaletteViewController *strongSelf = weakSelf;
        
        strongSelf.view.backgroundColor = [UIColor whiteColor];
    }];
}

-(void)validateCurrentPaletteColors {
    while(self.currentPaletteColors.count < 3) {
        [self.currentPaletteColors addObject:[UIColor colorNamed:@"PaletteColorBlack"]];
    }
}

#pragma mark Overrided methods
- (void)saveButtonHandler {
    [super saveButtonHandler];
    
    [self validateCurrentPaletteColors];
    [self.delegate saveButtonClickedWithColors:self.currentPaletteColors];
}

#pragma mark Palette Handlers
-(void)chooseColorHandler:(ColorButton *)colorButton {
    NSSet *uniqueColor = [NSSet setWithArray:self.currentPaletteColors];
    UIColor *buttonColor = colorButton.color;
    
    if (![uniqueColor containsObject:buttonColor]) {
        [self.currentPaletteColors addObject:buttonColor];
        
        if (self.currentPaletteColors.count > 3) {
            [self.currentPaletteColors removeObjectAtIndex:0];
        }
        
        [self changeViewBackgroundColorWith:buttonColor];
    } else {
        [self.currentPaletteColors removeObject:buttonColor];
    }
    
    [self updateColorButtonSelectedStatus];
}

@end
