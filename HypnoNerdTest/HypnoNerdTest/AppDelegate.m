//
//  AppDelegate.m
//  HypnoNerdTest
//
//  Created by Md. Milan Mia on 9/16/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "HypnosisViewController.h"
#import "ReminderViewController.h"
#import "AnotherViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    HypnosisViewController *hvc = (HypnosisViewController*)[sb instantiateViewControllerWithIdentifier:@"hypnosisView"];
    
    ReminderViewController *rvc = (ReminderViewController*)[sb instantiateViewControllerWithIdentifier:@"reminderView"];
    
    ReminderViewController *avc = (ReminderViewController*)[sb
        instantiateViewControllerWithIdentifier:@"anotherView"];
    
    hvc.tabBarItem.title = @"Hypnosis";
    hvc.tabBarItem.image = [UIImage imageNamed:@"screen"];
    
    rvc.tabBarItem.title = @"Reminder";
    rvc.tabBarItem.image = [UIImage imageNamed:@"cart"];
    
    avc.tabBarItem.title = @"Another";
    avc.tabBarItem.image = [UIImage imageNamed:@"screen"];
    
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    tabBarController.viewControllers = @[hvc, rvc, avc];
    [tabBarController setSelectedIndex: 1];
    
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
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
