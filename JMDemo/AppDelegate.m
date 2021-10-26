//
//  AppDelegate.m
//  JMDemo
//
//  Created by wookde on 2021/7/21.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "JMNetworkStatusTool.h"
#import "JMUploadIdfa.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[JMNetworkStatusTool defaultManager] startNotifier:^(NetworkStatus status) {
        [JMUpLoadIdfa upload];
    }];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
