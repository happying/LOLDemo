//
//  AppDelegate.m
//  LOLDemo
//
//  Created by yufu on 15/1/21.
//  Copyright (c) 2015年 yufu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MySelfDataForLOLDemoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.myTabBarController = [[UITabBarController alloc] init];
    [self.window setRootViewController:_myTabBarController];
    
    ViewController *firstViewController = [[ViewController alloc] init];
    ViewController *secondViewController = [[ViewController alloc] init];
    MySelfDataForLOLDemoViewController *thirdViewController = [[MySelfDataForLOLDemoViewController alloc] init];
    MySelfDataForLOLDemoViewController *fourthViewController = [[MySelfDataForLOLDemoViewController alloc] init];
    
    _myTabBarController.viewControllers = @[firstViewController, secondViewController, thirdViewController, fourthViewController];
    _myTabBarController.delegate = self;
    _myTabBarController.tabBar.backgroundImage = [[UIImage imageNamed:@"tab_bar_bkg_2@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _myTabBarController.tabBar.selectionIndicatorImage = [[UIImage imageNamed:@"tab_bar_selected2@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBar *myTabBar = _myTabBarController.tabBar;
    UITabBarItem *firstItem = [myTabBar.items objectAtIndex:0];
    UITabBarItem *secondItem = [myTabBar.items objectAtIndex:1];
    UITabBarItem *thirdItem = [myTabBar.items objectAtIndex:2];
    UITabBarItem *fourthItem = [myTabBar.items objectAtIndex:3];
    
    UIImage *firstUnSelecteImage = [UIImage imageNamed:@"tab_icon_news_normal@2x.png"];
    UIImage *firstSelecteImage = [UIImage imageNamed:@"tab_icon_news_press2@2x.png"];
    UIImage *secondUnSelecteImage = [UIImage imageNamed:@"tab_icon_friend_normal@2x.png"];
    UIImage *secondSelecteImage = [UIImage imageNamed:@"tab_icon_friend_press2@2x.png"];
    UIImage *thirdUnSelecteImage = [UIImage imageNamed:@"tab_icon_quiz_normal@2x.png"];
    UIImage *thirdSelecteImage = [UIImage imageNamed:@"tab_icon_quiz_press2@2x.png"];
    UIImage *fourthUnSelecteImage = [UIImage imageNamed:@"tab_icon_more_normal@2x.png"];
    UIImage *fourthSelecteImage = [UIImage imageNamed:@"tab_icon_more_press2@2x.png"];
    
    firstItem.image = [firstUnSelecteImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    firstItem.selectedImage = [firstSelecteImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secondItem.image = [secondUnSelecteImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secondItem.selectedImage = [secondSelecteImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    thirdItem.image = [thirdUnSelecteImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    thirdItem.selectedImage = [thirdSelecteImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    fourthItem.image = [fourthUnSelecteImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fourthItem.selectedImage = [fourthSelecteImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
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
