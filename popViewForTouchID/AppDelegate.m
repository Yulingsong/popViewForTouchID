//
//  AppDelegate.m
//  popViewForTouchID
//
//  Created by yulingsong on 16/8/4.
//  Copyright © 2016年 yulingsong. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "YLSTouchidView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //appdelegate
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:vc];
    _window.rootViewController = na;
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
    NSString *touchIDExist = [[NSUserDefaults standardUserDefaults]objectForKey:@"TouchID"];
    NSString *touchISOn = [[NSUserDefaults standardUserDefaults]objectForKey:@"touchIDISon"];
    NSLog(@"touchIDExist---%@---touchISOn---%@",touchIDExist,touchISOn);
    if ([touchIDExist isEqualToString:@"1"] && [touchISOn isEqualToString:@"NO"])
    {
        YLSTouchidView *yls = [[YLSTouchidView alloc]init];
        [yls show];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"touchIDISon"];
    });
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
