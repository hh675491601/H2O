//
//  AppDelegate.m
//  GamePlatform
//
//  Created by hehao on 15/8/27.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import "AppDelegate.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    
    OneViewController *oneVC = [[OneViewController alloc] init];
    oneVC.tabBarItem.title = @"热门";
    oneVC.tabBarItem.image = [UIImage imageNamed:@"file@2x.png"];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:oneVC];
    
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    twoVC.tabBarItem.title = @"热榜";
    twoVC.tabBarItem.image = [UIImage imageNamed:@"game@2x.png"];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:twoVC];
    
    ThreeViewController *threeVC = [[ThreeViewController alloc] init];
    threeVC.tabBarItem.title = @"游戏";
    threeVC.tabBarItem.image = [UIImage imageNamed:@"main@2x.png"];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:threeVC];
    
    FourViewController *fourVC = [[FourViewController alloc] init];
    fourVC.tabBarItem.title = @"软件";
    fourVC.tabBarItem.image = [UIImage imageNamed:@"news@2x.png"];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:fourVC];
    
    FiveViewController *fiveVC = [[FiveViewController alloc] init];
    fiveVC.tabBarItem.title = @"我的";
    fiveVC.tabBarItem.image = [UIImage imageNamed:@"person@2x.png"];
    fiveVC.tabBarItem.badgeValue = @"99+";
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:fiveVC];
    
    UITabBarController *tabbarVC = [[UITabBarController alloc] init];
    tabbarVC.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    tabbarVC.tabBar.tintColor = [UIColor redColor];
    self.window.rootViewController = tabbarVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
