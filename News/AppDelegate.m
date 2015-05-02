//
//  AppDelegate.m
//  News
//
//  Created by fengdaq on 15/3/10.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "AppDelegate.h"
#import "News_RootViewController.h"
#import "AFNetworking.h"
#import "News_HomePageViewController.h"

@interface AppDelegate ()
@property (nonatomic,retain)UIImageView* imageView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * listTop = [defaults objectForKey:@"listTop"];
    NSArray * listBottom = [defaults objectForKey:@"listBottom"];

    if (listTop == nil || listBottom == nil) {
        NSMutableArray * topArray = [[NSMutableArray alloc]initWithArray:@[@"推荐",@"iPhone",@"平板",@"相机",@"超极本",@"电视",@"摄像机"]];
        NSMutableArray * bottomArray = [NSMutableArray arrayWithArray:@[@"行情",@"DIY",@"家电",@"新闻"]];
        [defaults setObject:topArray forKey:@"listTop"];
        [defaults setObject:bottomArray forKey:@"listBottom"];

    }

    UINavigationBar * apperance = [UINavigationBar appearance];
    UIImage * image = [UIImage imageNamed:@"navback"];
    [apperance setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

    [_window setBackgroundColor:[UIColor whiteColor]];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
//                NSLog(@"未知网络");
            {
                News_RootViewController * rootVC = [[News_RootViewController alloc]init];
                self.window.rootViewController = rootVC;

            }
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [self creatAlert];
            {
                self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"404.jpg"]];
                _imageView.frame = [UIScreen mainScreen].bounds;
                [self.window addSubview:_imageView];
                
            }
                return ;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
//                NSLog(@"手机自带网络");
            {
                News_RootViewController * rootVC = [[News_RootViewController alloc]init];
                self.window.rootViewController = rootVC;
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
//                NSLog(@"WIFI");
            {
                News_RootViewController * rootVC = [[News_RootViewController alloc]init];
                self.window.rootViewController = rootVC;
            }
                break;
        }
    }];
    
    
    // 3.开始监控
    [mgr startMonitoring];

    return YES;
}

- (void)creatAlert
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您当前没有网络，请检查后再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        [self.imageView removeFromSuperview];
//        News_RootViewController *root = [[News_RootViewController alloc] init];
//        self.window.rootViewController = root;
//    }
//}
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
