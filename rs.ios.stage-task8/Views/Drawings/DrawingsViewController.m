//
//  DrawingsViewController.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/17/21.
//

#import "DrawingsViewController.h"
#import "UILabel+WithTitleAndColor.h"
#import "Button.h"

@interface DrawingsViewController ()

@property (nonatomic, strong) NSArray<NSString *> *drawings;
@property (nonatomic, strong, nullable) NSString *currentDrawing;

@end

@implementation DrawingsViewController

//@synthesize drawings, currentDrawing;

- (instancetype)initWithDrawings:(NSArray<NSString *> *)drawings andCurrentDrawing:(NSString *)currentDrawing {
    self = [super init];
    
    if (self) {
        _drawings = drawings;
        _currentDrawing = currentDrawing;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO: ????
    self.view.backgroundColor = [UIColor whiteColor];
    
    // setting up title view
    self.navigationItem.titleView = [UILabel getLabelWithTitle:@"Drawings"];
    
    [self setupLayout];
}

- (void)setupLayout {
    UIStackView *container = [UIStackView new];
    container.axis = UILayoutConstraintAxisVertical;
    container.spacing = 15;
    
    [self.drawings enumerateObjectsUsingBlock:^(NSString *drawing, NSUInteger idx, BOOL *stop) {
        Button *button = [Button buttonWithTitle:drawing handler:@selector(drawingButtonHandler:) andEnableStatus:YES];
        
        button.selected = [drawing isEqualToString:self.currentDrawing];
        
        [container addArrangedSubview:button];
    }];
    
    [self.view addSubview:container];
    
    container.translatesAutoresizingMaskIntoConstraints = NO;
    // MARK: Container contraints
    [NSLayoutConstraint activateConstraints:@[
        [container.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:50],
        [container.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    ]];
    
}

- (void) drawingButtonHandler:(Button *)sender {
    NSLog(@"drawing button handler");
    
    [self.delegate currentDrawingDidChange:sender.titleLabel.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
