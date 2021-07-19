//
//  ArtistViewController.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/16/21.
//

#import "ArtistViewController.h"
#import "DrawingsViewController.h"
#import "PaletteViewController.h"
#import "TimerViewController.h"
#import "UILabel+WithTitleAndColor.h"
#import "UIColor+WithPalleteColors.h"
#import "Button.h"
#import "Canvas.h"

typedef enum {
    idle,
    draw,
    done
} ArtistViewState;

@interface ArtistViewController ()

@property (nonatomic, strong, nullable) NSString *currentDrawing;
@property (nonatomic, strong) NSMutableArray<UIColor *> *currentPaletteColors;
@property (nonatomic, assign) float timerValue;
@property (nonatomic, strong) NSArray<Button *> *controlButtons;
@property (nonatomic, assign) ArtistViewState state;
@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, strong) Canvas *canvas;
@end

@implementation ArtistViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentDrawing = @"Head";
        _currentPaletteColors = [NSMutableArray arrayWithArray:@[
            [UIColor colorNamed:@"PaletteColorBlack"],
            [UIColor colorNamed:@"PaletteColorBlack"],
            [UIColor colorNamed:@"PaletteColorBlack"],
        ]];
        _timerValue = 1;
        _state = idle;
        
        [self addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // setting up title view
    self.navigationItem.titleView = [UILabel getLabelWithTitle:@"Artist"];
    
    // settting up right button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Drawings"
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(drawingsHandler)];
    
    // setting back button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Artist"
                                             style:UIBarButtonItemStylePlain
                                             target:nil
                                             action:nil];
    
    [self setupLayout];
}

#pragma mark Setting up layout
- (void)setupLayout {
    self.canvas = [self createCanvas];
    UIView *controllerContainer = [self createContainerAndControllers];
    
    
    // MARK: Canvas constraints
    self.canvas.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.canvas.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:40],
        [self.canvas.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:38],
        [self.canvas.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-37],
        [self.canvas.heightAnchor constraintEqualToConstant:300],
    ]];
    
    // MARK: Controller Container constraints
    controllerContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [controllerContainer.topAnchor constraintEqualToAnchor:self.canvas.bottomAnchor],
        [controllerContainer.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [controllerContainer.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [controllerContainer.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (Canvas *)createCanvas {
    Canvas *canvas = [[Canvas alloc] init];
    
    canvas.backgroundColor = [UIColor white];

    canvas.layer.cornerRadius = 8;

    canvas.layer.shadowRadius = 4;
    canvas.layer.shadowOpacity = 1;
    canvas.layer.shadowColor = [[UIColor chillSky] colorWithAlphaComponent:0.4].CGColor;
    canvas.layer.shadowOffset = CGSizeZero;
    
    [self.view addSubview:canvas];
    
    return canvas;
    
}

- (UIView *)createContainerAndControllers {
    UIView *container = [UIView new];
    
    UIStackView *controllerContainer = [UIStackView new];
    controllerContainer.axis = UILayoutConstraintAxisVertical;
    controllerContainer.spacing = 20;
    
    Button *openPaletteButton = [Button buttonWithTitle:@"Open Palette" handler:@selector(openPaletteHandler:) andEnableStatus:YES];
    Button *drawButton = [Button buttonWithTitle:@"Draw" handler:@selector(drawHandler:) andEnableStatus:YES];
    Button *openTimerButton = [Button buttonWithTitle:@"Open Timer" handler:@selector(openTimerHandler:) andEnableStatus:YES];
    Button *shareButton = [Button buttonWithTitle:@"Share" handler:@selector(shareHandler:) andEnableStatus:NO];
    
    self.controlButtons = @[openPaletteButton, drawButton, openTimerButton, shareButton];
    
    NSArray<NSArray<Button *>*> *buttons = @[
        @[
            openPaletteButton,
            drawButton,
        ],
        @[
            
            openTimerButton,
            shareButton,
        ]
    ];
    
    [buttons enumerateObjectsUsingBlock:^(NSArray<Button *> *items, NSUInteger idx, BOOL *stop) {
        UIStackView *row = [[UIStackView alloc] initWithArrangedSubviews:items];
        row.distribution = UIStackViewDistributionEqualSpacing;
        
        [controllerContainer addArrangedSubview:row];
    }];
    
    [container addSubview:controllerContainer];
    
    controllerContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [controllerContainer.topAnchor constraintEqualToAnchor:container.topAnchor constant:50],
        [controllerContainer.leadingAnchor constraintEqualToAnchor:container.leadingAnchor constant:20],
        [controllerContainer.trailingAnchor constraintEqualToAnchor:container.trailingAnchor constant:-41],
        [controllerContainer.bottomAnchor constraintEqualToAnchor:container.bottomAnchor constant:-129],
    ]];
    
    [self.view addSubview:container];
    
    return container;
}

- (void)resetHandler {
    self.state = idle;
    self.canvas.reset = YES;
    [self.canvas setNeedsDisplay];
}

#pragma mark Handlers
- (void)drawingsHandler {
    DrawingsViewController *drawingsVC = [[DrawingsViewController alloc]
                                          initWithDrawings:@[@"Planet", @"Head", @"Tree", @"Landscape"]
                                          andCurrentDrawing:self.currentDrawing];
    drawingsVC.delegate = self;
    
    [self.navigationController pushViewController:drawingsVC animated:YES];
}

-(void)openPaletteHandler:(Button *)sender {
    PaletteViewController *paletteVC = [[PaletteViewController alloc] initWithPaletteColors:self.currentPaletteColors];
    paletteVC.delegate = self;
    
    [self presentViewController:paletteVC animated:YES completion:nil];
}

-(void)openTimerHandler:(Button *)sender {
    TimerViewController *timerVC = [[TimerViewController alloc] initWithTimerValue:self.timerValue];
    timerVC.delegate = self;
    
    [self presentViewController:timerVC animated:YES completion:nil];
}

-(void)drawHandler:(Button *)sender {
    self.canvas.isReadyToDraw = YES;
    self.canvas.colors = [self.currentPaletteColors copy];
    self.canvas.templateName = self.currentDrawing;
//    self.canvas.templateName = @"Landscape";
    
    double timeInterval = (double)1/60 * (double)self.timerValue;
    self.state = draw;
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(drawTimer:) userInfo:nil repeats:YES];
}

-(void)shareHandler:(Button *)sender {
    NSLog(@"Share handler");
    UIImageWriteToSavedPhotosAlbum([self.canvas takeSnapshot], nil, nil, nil);
}

- (void)drawTimer:(NSTimer *)timer {
    if (self.canvas.isDrawingDone) {
        [timer invalidate];
        self.state = done;
        
        return;
    }
    
    [self.canvas setNeedsDisplay];
}

#pragma mark Drawing VC Delegate methods
-(void)currentDrawingDidChange:(NSString *)currentDrawing {
    self.currentDrawing = currentDrawing;
}

#pragma mark Palette VC Delegate methods
- (void)saveButtonClickedWithColors:(NSMutableArray<UIColor *> *)currentColors {
    self.currentPaletteColors = currentColors;
}

#pragma mark Timer VC Delegate methods
-(void)saveButtonClickedWithTimerValue:(float)timerValue {
    self.timerValue = timerValue;
}

#pragma mark Proprties observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"state"]) {
        ArtistViewState state = (ArtistViewState)[change[@"new"] integerValue];
        [self stateChanged:state];
    }
}

#pragma mark State Change Handler
-(void)stateChanged:(ArtistViewState)state {
    switch (state) {
        case idle: {
            __weak ArtistViewController *weakSelf = self;
            [self.controlButtons enumerateObjectsUsingBlock:^(Button *button, NSUInteger idx, BOOL *stop) {
                __strong ArtistViewController *strongSelf = weakSelf;
                
                button.enabled = YES;
                
                if ([button.titleLabel.text isEqualToString:@"Reset"]) {
                    [button removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
                    [button addTarget:strongSelf action:@selector(drawHandler:) forControlEvents:UIControlEventTouchUpInside];
                    [button setTitle:@"Draw" forState:UIControlStateNormal];
                }
                
                if ([button.titleLabel.text isEqualToString:@"Share"]) {
                    button.enabled = NO;
                }
            }];
            break;
        }
        case draw:
            [self.controlButtons enumerateObjectsUsingBlock:^(Button *button, NSUInteger idx, BOOL *stop) {
                button.enabled = NO;
            }];
            break;
        case done: {
            __weak ArtistViewController *weakSelf = self;
            [self.controlButtons enumerateObjectsUsingBlock:^(Button *button, NSUInteger idx, BOOL *stop) {
                if([button.titleLabel.text isEqualToString:@"Draw"]) {
                    __strong ArtistViewController *strongSelf = weakSelf;
                    [button removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
                    [button addTarget:strongSelf action:@selector(resetHandler) forControlEvents:UIControlEventTouchUpInside];
                    [button setTitle:@"Reset" forState:UIControlStateNormal];
                    button.enabled = YES;
                }
                
                if ([button.titleLabel.text isEqualToString:@"Share"]) {
                    button.enabled = YES;
                }
            }];
            break;
        }
        default:
            break;
    }
}
@end
