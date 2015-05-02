//
//  News_CommentsViewController.m
//  News
//
//  Created by fengdaq on 15/3/14.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_CommentsViewController.h"

@interface News_CommentsViewController ()

@end

@implementation News_CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_001"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBtnClicked:)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-15)];
    NSString * urlStr = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/doc_comment_new.php?id=%@&vs=iph382&imei=D4AD0193-6756-4E18-A117-6300800B96DA",_comId];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
    webView.scalesPageToFit = NO;//设置webView内容填充满屏幕
    webView.scrollView.bounces = NO;//设置webView在顶端时不能拖动
    webView.dataDetectorTypes = UIDataDetectorTypeAddress;//设置检测对象
    [self.view addSubview:webView];
    


}
//webView代理方法可以隐藏webView上的一些按钮
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)leftBtnClicked:(UIButton *)btn
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
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
