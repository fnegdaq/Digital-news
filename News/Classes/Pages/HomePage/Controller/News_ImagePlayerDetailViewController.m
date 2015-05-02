//
//  News_ImagePlayerDetailViewController.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_ImagePlayerDetailViewController.h"
#import "News_HomePageViewController.h"

@interface News_ImagePlayerDetailViewController ()

@end

@implementation News_ImagePlayerDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_001"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedLeftBtn)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -150, ViewWidth, ViewHeight+150)];
    webView.delegate = self;
    webView.scalesPageToFit = YES;//webView现实的内容充满屏幕
    webView.scrollView.bounces = NO;//设置view在顶端时不能向下拖动
    webView.dataDetectorTypes = UIDataDetectorTypeAddress;//设置需要检测的对象
    NSURL * detailUrl = [NSURL URLWithString:_detailPageUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:detailUrl];
    [webView loadRequest:request];
    [self.view addSubview:webView];

}
- (void)didClickedLeftBtn
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *tempString = [NSString stringWithFormat:@"document.getElementsByTagName('span')[0].innerHTML ='';"];
    [webView stringByEvaluatingJavaScriptFromString:tempString];
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
