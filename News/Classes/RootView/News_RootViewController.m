//
//  News_RootViewController.m
//  News
//
//  Created by fengdaq on 15/3/10.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_RootViewController.h"
#import "News_HomePageViewController.h"
#import "News_MyViewController.h"
#import "News_PictureTableViewController.h"
#import "News_PriceViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "ABCIntroView.h"
#import "SKSplashIcon.h"
@interface News_RootViewController () <ABCIntroViewDelegate>
@property (nonatomic,strong)SKSplashView * splashView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (retain ,nonatomic) ABCIntroView *introView;
@end

@implementation News_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
    News_HomePageViewController * homeVC = [[News_HomePageViewController alloc]init];
    UINavigationController * homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    homeVC.title = @"首页";
    [homeVC.tabBarItem setImage:[UIImage imageNamed:@"Box-2"]];
    [homeVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"Box-open"]];
    homeNav.navigationBar.translucent = NO;
    
    homeNav.navigationBar.backgroundColor = [UIColor blueColor];
    
    News_PriceViewController * priceVC = [[News_PriceViewController alloc]init];
    UINavigationController * priceNav = [[UINavigationController alloc]initWithRootViewController:priceVC];
    priceVC.title = @"产品查询";
    [priceVC.tabBarItem setImage:[UIImage imageNamed:@"Tag-1"]];
    [priceVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"Tag-2"]];
    priceNav.navigationBar.translucent = NO;
    
    News_PictureTableViewController * pictureVC = [[News_PictureTableViewController alloc]init];
    UINavigationController * pictureNav = [[UINavigationController alloc]initWithRootViewController:pictureVC];
    pictureVC.title = @"图赏";
    [pictureVC.tabBarItem setImage:[UIImage imageNamed:@"Folder"]];
   // [pictureVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"Folder-V"]];
    /**
     *  UIImageRenderingModeAutomatic  // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
     UIImageRenderingModeAlwaysOriginal   // 始终绘制图片原始状态，不使用Tint Color。
     UIImageRenderingModeAlwaysTemplate   // 始终根据Tint Color绘制图片，忽略图片的颜色信息。
     */
    pictureVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"Folder-V"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    pictureNav.navigationBar.translucent = NO;//41-picture-frame
    
    News_MyViewController * myVC = [[News_MyViewController alloc]init];
    UINavigationController * myNav = [[UINavigationController alloc]initWithRootViewController:myVC];
    myVC.title = @"个人中心";
    [myVC.tabBarItem setImage:[UIImage imageNamed:@"User-Round"]];
    [myVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"User"]];
    myNav.navigationBar.translucent = NO;//28-star

    self.viewControllers = @[homeNav,priceNav,pictureNav,myNav];
    self.tabBar.tintColor = [UIColor colorWithRed:0.25098 green:0.6 blue:1.0 alpha:1];
    self.tabBar.translucent = NO;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"intro_screen_viewed"] == nil) {
        [defaults setObject:@"hehe" forKey:@"intro_screen_viewed"];
        self.introView = [[ABCIntroView alloc] initWithFrame:self.view.frame];
        self.introView.delegate = self;
        self.introView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        [self.view addSubview:self.introView];
    }
    
    // [self twitterSplash];
    
}
- (void)onDoneButtonPressed
{
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
    }];
}

- (void) twitterSplash
{
    //Setting the background
    //    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.window.frame];
    //    imageView.image = [UIImage imageNamed:@"twitter background.png"];
    //    [self.window addSubview:imageView];
    //Twitter style splash
    SKSplashIcon *twitterSplashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"homePage"] animationType:SKIconAnimationTypeBounce];
    UIColor *twitterColor = [UIColor colorWithRed:0.25098 green:0.6 blue:1.0 alpha:1];
//    UIColor * twitterColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ez"]];
    self.splashView = [[SKSplashView alloc] initWithSplashIcon:twitterSplashIcon backgroundColor:twitterColor animationType:SKSplashAnimationTypeNone];
    self.splashView.delegate = self; //Optional -> if you want to receive updates on animation beginning/end
    self.splashView.animationDuration = 2; //Optional -> set animation duration. Default: 1s
    [self.view addSubview:_splashView];
    
    [self.splashView startAnimation];


}
- (void) splashView:(SKSplashView *)splashView didBeginAnimatingWithDuration:(float)duration
{
//    NSLog(@"Started animating from delegate");
    //To start activity animation when splash animation starts
    [_indicatorView startAnimating];
}

- (void) splashViewDidEndAnimating:(SKSplashView *)splashView
{
//    NSLog(@"Stopped animating from delegate");
    //To stop activity animation when splash animation ends
    [_indicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
