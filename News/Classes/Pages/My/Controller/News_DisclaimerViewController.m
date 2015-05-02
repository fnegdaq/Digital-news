//
//  News_DisclaimerViewController.m
//  News
//
//  Created by fengdaq on 15/3/24.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_DisclaimerViewController.h"

@interface News_DisclaimerViewController ()

@end

@implementation News_DisclaimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_001"] style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"免责声明";
    
    UILabel * disclaimerLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.1, ViewWidth*0.3, ViewWidth*0.8, ViewWidth*0.4)];
    disclaimerLabel.numberOfLines = 0;
    disclaimerLabel.text = @"    本软件部分数据来自太平洋电脑网，中关村在线，本APP不用于盈利性质的商业软件";
    [self.view addSubview:disclaimerLabel];
}
- (void)left
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
