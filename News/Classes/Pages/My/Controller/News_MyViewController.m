//
//  News_MyViewController.m
//  News
//
//  Created by fengdaq on 15/3/24.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_MyViewController.h"
#import "CExpandHeader.h"
#import "SDImageCache.h"
#import "News_emailViewController.h"
#import "News_AboutUsViewController.h"
#import "News_DisclaimerViewController.h"
#import "News_FavoriteViewController.h"
@interface News_MyViewController ()
{
    float tmpSize;
}
@property (retain, nonatomic) CExpandHeader *headView;
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSArray *titleNameArray;
@property (retain, nonatomic) UISwitch *oneSwith;
@property (retain, nonatomic) UILabel *oneLabel;
@property (assign, nonatomic) BOOL isSwith;

@end

@implementation News_MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"writeBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-80) style:UITableViewStyleGrouped];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.titleNameArray = @[@"夜间模式",@"产品收藏",@"清空缓存",@"建议反馈",@"关于我们",@"免责声明"];
    
    self.isSwith = NO;
    [self createHeaderView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getImageCache];
}

- (void)getImageCache
{
    tmpSize = [[SDImageCache sharedImageCache] checkTmpSize];
    
    [self.tableView reloadData];
}

- (void)createHeaderView
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight/3)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 ,0, ViewWidth, ViewHeight/3)];
    [imageView setImage:[UIImage imageNamed:@"mybackground.jpg"]];
    
    //关键步骤 设置可变化背景view属性
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;

    [customView addSubview:imageView];

    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth/2-50,ViewHeight/3/2-60, 100, 100)];
    header.layer.borderWidth = 2;
    header.layer.cornerRadius = 50;
    header.layer.masksToBounds=YES;
    
    header.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth/2-100, ViewHeight/3/2+50, 200, 50)];
//    oneLabel.text = @"DUANG  DIGITAL";
    oneLabel.text = @"PERSONAL CENTER";
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont fontWithName:@"SavoyeLetPlain" size:26.0];
    oneLabel.backgroundColor = [UIColor clearColor];
    
    
    [imageView addSubview:oneLabel];
    
    header.image = [UIImage imageNamed:@"Icon-60@3x"];
    header.backgroundColor = [UIColor redColor];
    [imageView addSubview:header];
    
//    NSArray *familyNames = [UIFont familyNames];
//    for( NSString *familyName in familyNames ){
//        printf( "Family: %s \n", [familyName UTF8String]);
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for( NSString *fontName in fontNames ){
//            printf( "\tFont: %s \n", [fontName UTF8String] );
//        }
//    }
    
    _headView = [CExpandHeader expandWithScrollView:_tableView expandView:customView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"firstCell"];
        }
        self.oneSwith = [[UISwitch alloc]init];
        _oneSwith.on = _isSwith;
        cell.accessoryView = _oneSwith;
        cell.textLabel.text = _titleNameArray[0];
        [_oneSwith addTarget:self action:@selector(didClickToEvening) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"secondCell"];
        }
        self.oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        _oneLabel.text = tmpSize > 1 ?[NSString stringWithFormat:@"(%.2fM)",tmpSize] : [NSString stringWithFormat:@"(%.2fK)",tmpSize * 1024];
        _oneLabel.textAlignment = NSTextAlignmentRight;
        cell.accessoryView = _oneLabel;
        cell.textLabel.text = _titleNameArray[2];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"thirdCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = _titleNameArray[indexPath.row];
        return cell;
    }
}

- (void)didClickToEvening
{
    if (_oneSwith.on == YES) {
        self.isSwith = _oneSwith.on;
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
        oneView.backgroundColor = [UIColor blackColor];
        oneView.alpha = 0.4;
        oneView.tag = 10010;
        oneView.userInteractionEnabled = NO;
        [self.view.window addSubview:oneView];
    }else{
         self.isSwith = _oneSwith.on;
        UIView *otherView = [self.view.window viewWithTag:10010];
        [otherView removeFromSuperview];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        News_FavoriteViewController *favVC = [[News_FavoriteViewController alloc]init];
        [self.navigationController pushViewController:favVC animated:YES];
    }
    
    if (indexPath.row == 2) {
        
        UIAlertView *oneAlert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"确定清空缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [oneAlert show];
    }
    if (indexPath.row == 3) {
        News_emailViewController *suggest = [[News_emailViewController alloc]init];
        [self.navigationController pushViewController:suggest animated:YES];
    }
    if (indexPath.row == 4) {

        News_AboutUsViewController * aboutUsVC = [[News_AboutUsViewController alloc]init];
        UINavigationController * abNav = [[UINavigationController alloc]initWithRootViewController:aboutUsVC];
        [self.navigationController presentViewController:abNav animated:YES completion:^{
            
        }];
    }
    if (indexPath.row == 5) {
        News_DisclaimerViewController * disclaimerVC = [[News_DisclaimerViewController alloc]init];
        UINavigationController * disclaimerNav = [[UINavigationController alloc]initWithRootViewController:disclaimerVC];
        [self.navigationController presentViewController:disclaimerNav animated:YES completion:^{
            
        }];
    }
}
/**
 *  实现UIAlertViewDelegate 中方法
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[SDImageCache sharedImageCache] clearDisk];
        tmpSize= 0.0;
//        NSLog(@"%f",tmpSize);
        [self.tableView reloadData];
    }
}


//- (void)didClickSettingLight
//{
//    UISlider *otherSlider = (UISlider *)[self.view viewWithTag:10086];
//    UIView *otherView = [self.view.window viewWithTag:10010];
//    otherView.alpha = otherSlider.value;
//}

@end
