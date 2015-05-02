//
//  News_ProductDetailViewController.m
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_ProductDetailViewController.h"
#import "News_PDetailPicViewCell.h"
#import "News_PDetailExplainViewCell.h"
#import "News_PDetailConfigViewCell.h"
#import "News_ProductDetailModel.h"
#import "UITableViewCell+TextHeight.h"
#import "News_ProductDetailConfigViewController.h"
#import "News_ProductDetailPhotoViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "DataBaseHandle.h"

@interface News_ProductDetailViewController ()

@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *seriesInfoArray;
@property (retain, nonatomic) NSMutableArray *configArray;
@property (retain, nonatomic) NSMutableDictionary *seriesInfoDic;
@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation News_ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-64)
                                                 style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.title = @"产品详情";
    
    [self setupMBProgressHUD];
    [self analysisData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"29-heart.png"]
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(didClickSave)];
 
    if ([[DataBaseHandle shareInstance]isFavoProductByName:self.proName])
    {
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor redColor];
    }
}

- (void)didClickSave
{
    BOOL isSave = [[DataBaseHandle shareInstance]insertProduct:self.proName
                                                         ProId:self.proId
                                                      SeriesId:self.seriesId];;
    
    if (isSave)
    {
        UIAlertView *alertSuccess = [[UIAlertView alloc]initWithTitle:@"收藏成功"
                                                              message:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:@"OK", nil];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor redColor];
        [alertSuccess show];
    }else
    {
        UIAlertView *alertFail = [[UIAlertView alloc]initWithTitle:@"该产品已收藏"
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"OK", nil];
        [alertFail show];
    }
}

- (void)setupMBProgressHUD
{
    self.hud = [[MBProgressHUD alloc]init];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    [_hud show:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES ;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO ;
}

- (void)analysisData
{
    NSString *urlPath = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_391_SeriesDetail&noParam=1&seriesId=%@",self.seriesId];
    [[RequestHandle alloc]initWithUrlString:urlPath paramUrl:nil method:@"GET" delegate:self];
}

- (void)setRequestHandle:(RequestHandle *)requestHandle requestSuccessData:(NSData *)successData
{
    [_hud hide:YES];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:successData options:NSJSONReadingMutableContainers error:nil];
   
    self.seriesInfoArray = [NSMutableArray array];
    self.configArray = [NSMutableArray array];
    
    NSArray *paramArray = dic[@"paramArr"];
    for (NSDictionary *dic in paramArray) {
        News_ProductDetailModel *proDetailModel = [[News_ProductDetailModel alloc]init];
        [proDetailModel setValuesForKeysWithDictionary:dic];
        [_configArray addObject:proDetailModel];
    }
    
    /**
     *  有的url不一样 判断重新解析...
     */
    NSDictionary *seriesInfoDic = dic[@"seriesInfo"];
    if (seriesInfoDic == nil) {
        [self analysisDataAgain];
    }
    
    News_ProductDetailModel *proDetailModel = [[News_ProductDetailModel alloc]init];
    [proDetailModel setValuesForKeysWithDictionary:seriesInfoDic];
    [_seriesInfoArray addObject:proDetailModel];
    
    
    [self.tableView reloadData];
}

- (void)analysisDataAgain
{
    NSString *urlPath = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_391_ProDetail&noParam=1&proId=%@",self.proId];
 
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"application/json",@"text/html",@"text/javascript", nil]];
    [manager GET:urlPath
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        [_hud hide:YES];
        NSDictionary *dic = (NSDictionary*)responseObject;
        
        self.configArray = [NSMutableArray array];
        NSArray *array = dic[@"sortParam"];
        for (NSDictionary *dic in array)
        {
            News_ProductDetailModel *proDetailModel = [[News_ProductDetailModel alloc]init];
            [proDetailModel setValuesForKeysWithDictionary:dic];
            [_configArray addObject:proDetailModel];
        }
        
        self.seriesInfoArray = [NSMutableArray array];
        NSDictionary *oneDic = dic[@"proInfo"];
        News_ProductDetailModel *proDetail = [[News_ProductDetailModel alloc]init];
        [proDetail setValuesForKeysWithDictionary:oneDic];
        if (!proDetail.priceRange)
        {
            proDetail.priceRange = oneDic[@"price"];
        }
        [_seriesInfoArray addObject:proDetail];
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return _configArray.count;
    }else{
    return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        return 15;
    }else{
    return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return ViewHeight/3+50;
    }else if (indexPath.section == 1){
        CGFloat height = [News_PDetailExplainViewCell getText:[_seriesInfoArray[0] brief] FontSize:15 Width:ViewWidth-20];
        return 80+height > 105 ? 105+height : 90;;
    }else if (indexPath.section == 2){
        CGFloat height2 = [News_PDetailConfigViewCell getText:[[_configArray objectAtIndex:indexPath.row] configValue] FontSize:15.0 Width:ViewWidth/3.0*2-20];
        CGFloat height3 = [News_PDetailConfigViewCell getText:[[_configArray objectAtIndex:indexPath.row] name] FontSize:15.0 Width:(ViewWidth)/4];
        return height2+height3;
    }else{
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 40;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 35)];
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ViewWidth-20, 30)];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.textColor = [UIColor lightGrayColor];
    oneLabel.font = [UIFont systemFontOfSize:14.0];
    oneLabel.text = @"科技前沿";
    [oneView addSubview:oneLabel];
    return oneView;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return @"digital";
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // static NSString *oneCell = @"cellIdentifier";
    
    if(indexPath.section == 0)
    {
    News_PDetailPicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hehe"];
    if (cell == nil)
    {
        cell = [[News_PDetailPicViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hehe"];
    }
        cell.productPic = _seriesInfoArray[0];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
        
    }else if(indexPath.section == 1)
    {
        News_PDetailExplainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"haha"];
        if (cell == nil)
        {
            cell = [[News_PDetailExplainViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"haha"];
        }
        cell.productDetail = _seriesInfoArray[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(indexPath.section == 2)
    {
        News_PDetailConfigViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"heihei"];
        if (cell == nil)
        {
            cell = [[News_PDetailConfigViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"heihei"];
        }
            cell.productDetail = _configArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"oneCell"];
        }
        UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ViewWidth-20, 30)];
        oneLabel.textAlignment = NSTextAlignmentCenter;
        if (_configArray.count)
        {
            oneLabel.text = @"点击查看详细配置  >";
        }
        oneLabel.textColor = [UIColor colorWithRed:0/255 green:132.0/255 blue:255.0/255 alpha:0.92];
        oneLabel.font = [UIFont systemFontOfSize:14.0];
        [cell.contentView addSubview:oneLabel];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        News_ProductDetailConfigViewController *configVC = [[News_ProductDetailConfigViewController  alloc]init];
        configVC.proId = self.proId;
        [self.navigationController pushViewController:configVC animated:YES];
    }
    if (indexPath.section == 0) {
        News_ProductDetailPhotoViewController *photo = [[News_ProductDetailPhotoViewController alloc]init];
        photo.proId = self.proId;
        photo.seriesId = self.seriesId;
        [self.navigationController pushViewController:photo animated:YES];
    }
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
