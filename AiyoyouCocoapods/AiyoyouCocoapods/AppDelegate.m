//
//  AppDelegate.m
//  AiyoyouCocoapods
//
//  Created by aiyoyou on 2016/11/27.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window                     = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor     = [UIColor whiteColor];
    MainViewController *vc          = [[MainViewController alloc]init];
    UINavigationController *nav     = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.navigationBar.translucent   = NO;//关闭导航栏半透明效果。
    [AppDelegate setNavAndTabBarControllerAttribute];
    self.window.rootViewController  = nav;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//设置导航栏和标签栏属性（程序启动后调用一次）
+ (void)setNavAndTabBarControllerAttribute {
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0 green:162/255.0 blue:255/255.0 alpha:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBarItem
      appearance] setTitleTextAttributes:[NSDictionary
                                          dictionaryWithObjectsAndKeys: [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1],
                                          NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem
      appearance] setTitleTextAttributes:[NSDictionary
                                          dictionaryWithObjectsAndKeys: [UIColor colorWithRed:61/255.0 green:164/255.0 blue:252/255.0 alpha:1],
                                          NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
}


@end
