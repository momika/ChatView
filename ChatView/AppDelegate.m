//
//  AppDelegate.m
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController *vcCtrl = [[ViewController alloc] init];
    vcCtrl.title = @"Chat";
    UINavigationController *uncCtrl = [[UINavigationController alloc] initWithRootViewController:vcCtrl];
    
    self.window.rootViewController = uncCtrl;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
