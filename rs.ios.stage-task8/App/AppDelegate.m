//
//  AppDelegate.m
//  rs.ios.stage-task8
//
//  Created by Vladislav Slizhevsky on 7/16/21.
//

#import "AppDelegate.h"
#import "ArtistViewController.h"
#import "UIColor+WithPalleteColors.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIFont *font = [UIFont fontWithName:@"Montserrat" size:17];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor lightGreenSea]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
        NSFontAttributeName: font
    } forState:UIControlStateNormal];
    [[UILabel appearance] setFont:font];
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]] setFont:font];
    [[UISlider appearance] setTintColor:[UIColor lightGreenSea]];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    ArtistViewController *artistVC = [[ArtistViewController alloc] init];
    UINavigationController *rootVC = [[UINavigationController alloc] initWithRootViewController:artistVC];
    
    window.rootViewController = rootVC;
    
    self.window = window;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
