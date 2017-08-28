//
//  AppDelegate.m
//  The Elements
//
//  Created by 李占昆 on 17/6/25.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "AppDelegate.h"
#import "ElementsTableViewController.h"
#import "ElementsDataSourceProtocol.h"
#import "ElementsSortedByNameDataSource.h"
#import "ElementsSortedByAtomicNumberDataSource.h"
#import "ElementsSortedBySymbolDataSource.h"
#import "ElementsSortedByStateDataSource.h"
#import "PeriodicElements.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [PeriodicElements sharedPeriodicElements];
    
    UITabBarController *tabbarController = [UITabBarController new];
    
    id <ElementsDataSourceProtocol, UITableViewDataSource> delegate;
    
    ElementsTableViewController *nameVC = [[ElementsTableViewController alloc] init];
    delegate = [ElementsSortedByNameDataSource new];
    nameVC.delegate = delegate;
    UINavigationController *nameNavigationController = [[UINavigationController alloc] initWithRootViewController:nameVC];
    
    ElementsTableViewController *atomicNumberVC = [[ElementsTableViewController alloc] init];
    delegate = [ElementsSortedByAtomicNumberDataSource new];
    atomicNumberVC.delegate = delegate;
    UINavigationController *atomicNumberNavigationController = [[UINavigationController alloc] initWithRootViewController:atomicNumberVC];
    
    ElementsTableViewController *symbolVC = [[ElementsTableViewController alloc] init];
    delegate = [ElementsSortedBySymbolDataSource new];
    symbolVC.delegate = delegate;
    UINavigationController *symbolNavigationController = [[UINavigationController alloc] initWithRootViewController:symbolVC];
    
    ElementsTableViewController *stateVC = [[ElementsTableViewController alloc] init];
    delegate = [ElementsSortedByStateDataSource new];
    stateVC.delegate = delegate;
    UINavigationController *stateNavigationController = [[UINavigationController alloc] initWithRootViewController:stateVC];
    
    tabbarController.viewControllers = @[nameNavigationController, atomicNumberNavigationController, symbolNavigationController, stateNavigationController];
    
    self.window.rootViewController = tabbarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
