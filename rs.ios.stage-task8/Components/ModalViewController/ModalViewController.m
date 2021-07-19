//
//  ModalViewController.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/18/21.
//

#import "ModalViewController.h"
#import "ModalPresentationController.h"
#import "Button.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupLayout];
}

- (void)setupLayout {
    [self setupViewAppearance];
    [self setupSaveButton];
}

- (void)setupViewAppearance {
    self.view.backgroundColor = [UIColor whiteColor];

    self.view.layer.cornerRadius = 40;
    self.view.layer.maskedCorners = kCALayerMaxXMinYCorner | kCALayerMinXMinYCorner;
    
    self.view.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.25].CGColor;
    self.view.layer.shadowOffset = CGSizeZero;
    self.view.layer.shadowRadius = 4;
    self.view.layer.shadowOpacity = 1;
}

- (void)setupSaveButton {
    Button *saveButton = [Button buttonWithTitle:@"Save" handler:@selector(saveButtonHandler) andEnableStatus:YES];
    
    [self.view addSubview:saveButton];
    
    saveButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [saveButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20],
        [saveButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:250],
        [saveButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
    ]];
}

#pragma mark VC Handler
- (void)saveButtonHandler {
    [self dismissViewControllerAnimated:self completion:nil];
}

#pragma mark UIViewControllerTransition Delegate methods
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    ModalPresentationController *presentationController = [[ModalPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    return presentationController;
}
@end
