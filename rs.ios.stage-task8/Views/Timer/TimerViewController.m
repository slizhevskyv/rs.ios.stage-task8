//
//  TimerViewController.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@property (nonatomic, strong) UILabel *sliderLabel;
@property (nonatomic, assign) float timerValue;

@end

@implementation TimerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timerValue = 1;
    }
    return self;
}

- (instancetype)initWithTimerValue:(float)timerValue {
    self = [super init];
    if (self) {
        _timerValue = timerValue;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTimerLayout];
}

-(void)setupTimerLayout {
    UIStackView *container = [UIStackView new];
    container.axis = UILayoutConstraintAxisVertical;
    container.spacing = 25;
    
    UIStackView *sliderContainer = [UIStackView new];
    sliderContainer.spacing = 41;
    
    UILabel *sliderMinValueLabel = [self createSliderLabelWithText:@"1"];
    
    UILabel *sliderMaxValueLabel = [self createSliderLabelWithText:@"5"];
    
    UISlider *slider = [UISlider new];
    slider.minimumValue = 1;
    slider.maximumValue = 5;
    slider.value = self.timerValue;
    [slider addTarget:self action:@selector(sliderHandler:) forControlEvents:UIControlEventValueChanged];
    
    [sliderContainer addArrangedSubview:sliderMinValueLabel];
    [sliderContainer addArrangedSubview:slider];
    [sliderContainer addArrangedSubview:sliderMaxValueLabel];
    
    self.sliderLabel = [self createSliderLabelWithText:[NSString stringWithFormat:@"%.2f s", slider.value]];
    self.sliderLabel.textAlignment = NSTextAlignmentCenter;
    
    [container addArrangedSubview:sliderContainer];
    [container addArrangedSubview:self.sliderLabel];
    
    [self.view addSubview:container];
    
    // MARK: Constraints
    container.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [container.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:92],
        [container.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:26],
        [container.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-26],
    ]];
}

-(UILabel *)createSliderLabelWithText:(NSString *)text {
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = [UIFont fontWithName:@"Montserrat" size:18];
    
    return label;
}

#pragma mark Overrided methods
- (void)saveButtonHandler {
    [super saveButtonHandler];
    
    [self.delegate saveButtonClickedWithTimerValue:self.timerValue];
}

#pragma mark Timer VC Handlers
-(void)sliderHandler:(UISlider *)sender {
    self.sliderLabel.text = [NSString stringWithFormat:@"%.2f s", sender.value];
    self.timerValue = sender.value;
}

@end
