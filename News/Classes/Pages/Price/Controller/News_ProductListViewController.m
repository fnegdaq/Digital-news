//
//  News_ProductListViewController.m
//  News
//
//  Created by fengdaq on 15/3/13.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#define ProductIdentifier @"ProductIdentifier"

#import "News_ProductListViewController.h"
#import "News_ProductListViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "News_ProductDetailViewController.h"
#import "News_ProduceListModel.h"
#import "AFNetworking.h"

@interface News_ProductListViewController ()

{
    BOOL _clearFlag;
    UIImageView* _clearImg;
    UIButton* _firstBtn;
    UIButton* _secondBtn;
    UIButton* _thirdBtn;
    UIButton* _fourthBtn;
}

@property (retain, nonatomic) MBProgressHUD *hub;

@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *allInfoArray;
@property (assign, nonatomic) NSInteger currentPage;

@end

@implementation News_ProductListViewController

-(id)initWithUrl:(NSString *)url
{
    self = [super  init];
    
    if (self) {
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.titleName;
    
 
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[News_ProductListViewCell class] forCellReuseIdentifier:ProductIdentifier];
    
    [self.view addSubview:_tableView];

    self.allInfoArray = [NSMutableArray array];

    
    
    //菊花
    [self setupMBProgressHUD];
    [self analysisData];
    
    self.orderBy = nil;
    self.currentPage = 1;
    //self.manuId = nil;
   // self.subcateId = nil;  //不能设空,设了就刷不出数据..
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf refreshMoreData];
    }];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

//- (NSMutableArray *)allInfoArray
//{
//    if (_allInfoArray == nil) {
//        _allInfoArray = [NSMutableArray array];
//    }
//    return _allInfoArray;
//}

- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES ;
}

- (void)viewWillAppear:(BOOL)animated{
    /**
     *  下拉菜单~
     */
    [self createNavRightButton];
    [self initRightSettingView];
}

- (void)setupMBProgressHUD
{
    self.hub = [[MBProgressHUD alloc]initWithView:self.view];
    _hub.frame = self.view.bounds;
    _hub.minSize = CGSizeMake(100, 100);
    _hub.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hub];
    [_hub show:YES];
}

- (void)analysisData
{
    
//    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    
//    // 检测网络连接的单例,网络变化时的回调方法
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//       // NSLog(@"%ld", status);
//    }];
////    if (AFNetworkReachabilityStatusReachableViaWiFi) {
////        <#statements#>
////    }
//    
    
    NSString *urlPath = @"";
    
    if (_keyValue) {
        urlPath = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_391_List&noParam=1&num=20&keyword=%@&manuId=&orderBy=&page=%ld&paramVal=&priceId=noPrice&subcateId=",self.keyValue,(long)self.currentPage];
    }else{
     urlPath = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_391_List&noParam=1&num=20&keyword=&manuId=%@&orderBy=%@&page=%ld&paramVal=&priceId=noPrice&subcateId=%@",self.manuId,self.orderBy,(long)self.currentPage,self.subcateId];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
    [manager GET:urlPath
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        [_hub hide:YES];
        
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSArray *array = dic[@"data"];

        for (NSDictionary *dic in array)
        {
            News_ProduceListModel *produce = [[News_ProduceListModel alloc]init];
            [produce setValuesForKeysWithDictionary:dic];
            [_allInfoArray addObject:produce];
        }
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

/**
 *  下拉,  currentPage赋值后 直接调用analysisData 下拉刷新 会消失掉.. 问题原因:_allInfoArray数组在analysisData中做了初始化,所以每次调用就tm没了...
 */
- (void)refreshMoreData
{
    self.currentPage += 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self analysisData];
    });
    //拿到当前的上拉刷新控件，变为没有更多数据的
    if (_currentPage == 6) {
        [self.tableView.footer noticeNoMoreData];
    }
}


- (void)createNavRightButton
{
    _clearFlag = YES;
    
    self.navRightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [_navRightButton setFrame:CGRectMake(ViewWidth-40, 7, 30, 30)];
    [_navRightButton setBackgroundImage:[UIImage imageNamed:@"Settings-3@2x.png"] forState:UIControlStateNormal];
    [_navRightButton addTarget:self
                        action:@selector(didClickRightButton)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:_navRightButton];
    
}
/**
 *  视图将要消失的时候 销毁buttom
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO ;
    [_navRightButton removeFromSuperview];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [_firstBtn removeFromSuperview];
    [_secondBtn removeFromSuperview];
    [_thirdBtn removeFromSuperview];
    [_fourthBtn removeFromSuperview];
    [_clearImg removeFromSuperview];
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
    return _allInfoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_ProductListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductIdentifier forIndexPath:indexPath];
    
    News_ProduceListModel *productModel = _allInfoArray[indexPath.row];
    cell.produceModel = productModel;
    

    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

/**
 *  点击事件
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_ProductDetailViewController *detailView = [[News_ProductDetailViewController alloc]init];
    detailView.seriesId = [[_allInfoArray objectAtIndex:indexPath.row] seriesId];
    detailView.proId = [[_allInfoArray objectAtIndex:indexPath.row] proId];
    detailView.proName = [[_allInfoArray objectAtIndex:indexPath.row] name];
    [self.navigationController pushViewController:detailView animated:YES];
}

#pragma mark-----------------------下拉菜单
/**
 *  右上按钮动画效果
 */
- (void)didClickRightButton
{
    if (_clearFlag)
    {
        _clearImg.hidden = NO;
        
        CGAffineTransform navRound =CGAffineTransformMakeRotation(M_PI/-3);//先顺时钟旋转90
       // navRound =CGAffineTransformTranslate(navRound,0,0);
        
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction|
                                     UIViewAnimationOptionBeginFromCurrentState)
                         animations:^(void) {
                             
                             _firstBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*0);
                             _secondBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*1);
                             _thirdBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*2);
                             _fourthBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*3);
                             
                             _firstBtn.alpha = 1;
                             _secondBtn.alpha = 1;
                             _thirdBtn.alpha = 1;
                             _fourthBtn.alpha = 1;
                             
                             [_navRightButton setTransform:navRound];
                             
                         }
                         completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                 
                                 _firstBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,40.0*0);
                                 _secondBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,40.0*1);
                                 _thirdBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,40.0*2);
                                 _fourthBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,40.0*3);
                                 
                             } completion:NULL];
                         }];
    }
    else
    {
        _clearImg.hidden = YES;
        
        CGAffineTransform navRound =CGAffineTransformMakeRotation(0);//先顺时钟旋转90
        navRound =CGAffineTransformIdentity;
        
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction|
                                     UIViewAnimationOptionBeginFromCurrentState)
                         animations:^(void) {
                             
                             _firstBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*0);
                             _secondBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*0);
                             _thirdBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*0);
                             _fourthBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*0);
                             
                             _firstBtn.alpha = 0;
                             _secondBtn.alpha = 0;
                             _thirdBtn.alpha = 0;
                             _fourthBtn.alpha = 0;
                             
                             [_navRightButton setTransform:navRound];
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }
    _clearFlag = !_clearFlag;
}

-(void)initRightSettingView
{
    if (BIGTHANI5S) {
    _clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth/3*2.0+20, 0, ViewWidth/2, 170)];
    }else{
    _clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth/3*2.0, 0, ViewWidth/2, 170)];
    }
    _clearImg.backgroundColor = [UIColor colorWithRed:0/255 green:132.0/255 blue:255.0/255 alpha:0.85];
    //_clearImg.backgroundColor = [UIColor colorWithWhite:0.92 alpha:0.8];
    //_clearImg.backgroundColor = [UIColor whiteColor];
    _clearImg.hidden = YES;
    
    _firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_firstBtn setFrame:CGRectMake(ViewWidth-100, 0, 100, 40)];
    [_firstBtn setTitle:@"热门排列" forState:UIControlStateNormal];
    //[_firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_secondBtn setFrame:CGRectMake(ViewWidth-100, 0, 100, 40)];
    [_secondBtn setTitle:@"最新排列" forState:UIControlStateNormal];
    
    _thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_thirdBtn setFrame:CGRectMake(ViewWidth-100, 0, 100, 40)];
    [_thirdBtn setTitle:@"价高排列" forState:UIControlStateNormal];
    
    _fourthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fourthBtn setFrame:CGRectMake(ViewWidth-100, 0, 100, 40)];
    [_fourthBtn setTitle:@"价低排列" forState:UIControlStateNormal];
    
//    _firstBtn.tag = 101;
//    _secondBtn.tag = 102;
//    _thirdBtn.tag = 103;
//    _fourthBtn.tag = 104;
    
    _fourthBtn.alpha = 0;
    _firstBtn.alpha = 0;
    _secondBtn.alpha = 0;
    _thirdBtn.alpha = 0;
    
    [_thirdBtn addTarget:self action:@selector(didClickSwithOrderByWayThree) forControlEvents:UIControlEventTouchUpInside];
    [_firstBtn addTarget:self action:@selector(didClickSwithOrderByWayOne) forControlEvents:UIControlEventTouchUpInside];
    [_secondBtn addTarget:self action:@selector(didClickSwithOrderByWayTwo) forControlEvents:UIControlEventTouchUpInside];
    [_fourthBtn addTarget:self action:@selector(didClickSwithOrderByWayFour) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_clearImg];
    [self.view addSubview:_firstBtn];
    [self.view addSubview:_secondBtn];
    [self.view addSubview:_thirdBtn];
    [self.view addSubview:_fourthBtn];
}
/**
 *   - -||| 先就这吧..
 */
- (void)didClickSwithOrderByWayOne
{
    _clearFlag = NO;
    self.orderBy = @"1";
    self.allInfoArray = [NSMutableArray array];
    [self setupMBProgressHUD];
    [self analysisData];
    [self didClickRightButton];
}
- (void)didClickSwithOrderByWayTwo
{
    _clearFlag = NO;
    self.orderBy = @"14";
    self.allInfoArray = [NSMutableArray array];

    [self setupMBProgressHUD];
    [self analysisData];
    [self didClickRightButton];
   
}
- (void)didClickSwithOrderByWayThree
{
    _clearFlag = NO;
    self.orderBy = @"4";
    self.allInfoArray = [NSMutableArray array];
    [self setupMBProgressHUD];
    [self analysisData];
    [self didClickRightButton];

}
- (void)didClickSwithOrderByWayFour
{
    _clearFlag = NO;
    self.orderBy = @"3";
    self.allInfoArray = [NSMutableArray array];
    [self setupMBProgressHUD];
    [self analysisData];
    [self didClickRightButton];

}



@end
