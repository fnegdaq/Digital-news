//
//  News_emailViewController.m
//  News
//
//  Created by fengdaq on 15/3/24.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_emailViewController.h"

@interface News_emailViewController ()

@property (retain, nonatomic) UILabel *oneLabel;
@property (retain, nonatomic) UILabel *otherLabel;
@property (retain, nonatomic) UITextView *oneTextView;
@property (retain, nonatomic) UITextField *userTextView;
@end

@implementation News_emailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"建议反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCustomView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(didclickCommit)];
}

- (void)didclickCommit
{
    if ([_oneTextView.text isEqualToString:@""] || [_userTextView.text isEqualToString:@""]) {
        UIAlertView *OneAlert = [[UIAlertView alloc]initWithTitle:@"建议或联系方式不能为空" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [OneAlert show];
    }else{
        UIAlertView *otherAlert = [[UIAlertView alloc]initWithTitle:@"提交成功" message:@"感谢您的建议" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [otherAlert show];
        _oneTextView.text = @"";
        _userTextView.text = @"";
    }
}

- (void)createCustomView
{
    self.oneTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, ViewWidth-20, ViewHeight/4)];
    
   // oneTextView.layer.borderWidth = 1;
    _oneTextView.layer.cornerRadius = 8;
    _oneTextView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    _oneTextView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _oneTextView.font = [UIFont systemFontOfSize:17.0];
    _oneTextView.delegate = self;
//    self.oneTextView.text = @"们会认真对待您的每一条宝贵建议";
    self.oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 10, ViewWidth-20, 40)];
    _oneLabel.text = @"我们会认真对待您的每一条宝贵建议";
    _oneLabel.enabled = NO;
    _oneLabel.backgroundColor = [UIColor clearColor];

    
    self.userTextView = [[UITextField alloc]initWithFrame:CGRectMake(10, ViewHeight/4+20, ViewWidth-20, 40)];
    _userTextView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
   // userTextView.layer.borderWidth = 1;
    _userTextView.layer.cornerRadius = 8;
    _userTextView.font = [UIFont systemFontOfSize:16.0];
    _userTextView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    _userTextView.placeholder = @"请留下您的联系方式:(QQ/邮箱)";
    
    [self.view addSubview:_userTextView];
    [self.view addSubview:_oneTextView];
    [self.view addSubview:_oneLabel];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _oneLabel.text = @"我们会认真对待您的每一条宝贵建议";
    }else{
        _oneLabel.text = @"";
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
