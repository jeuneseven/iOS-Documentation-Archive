//
//  AppDelegate.m
//  The Elements
//
//  Created by 李占昆 on 17/6/25.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "AppDelegate.h"
#import "ElementsTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *tabbarController = [UITabBarController new];
    
    ElementsTableViewController *nameVC = [[ElementsTableViewController alloc] init];
    UINavigationController *nameNavigationController = [[UINavigationController alloc] initWithRootViewController:nameVC];
    
    ElementsTableViewController *atomicNumberVC = [[ElementsTableViewController alloc] init];
    UINavigationController *atomicNumberNavigationController = [[UINavigationController alloc] initWithRootViewController:atomicNumberVC];
    
    ElementsTableViewController *symbolVC = [[ElementsTableViewController alloc] init];
    UINavigationController *symbolNavigationController = [[UINavigationController alloc] initWithRootViewController:symbolVC];
    
    ElementsTableViewController *stateVC = [[ElementsTableViewController alloc] init];
    UINavigationController *stateNavigationController = [[UINavigationController alloc] initWithRootViewController:stateVC];
    
    tabbarController.viewControllers = @[nameNavigationController, atomicNumberNavigationController, symbolNavigationController, stateNavigationController];
    
    self.window.rootViewController = tabbarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
