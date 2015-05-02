//
//  News_HomePageViewController.m
//  News

//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//
#pragma mark-----juhua---------
#import "MBProgressHUD.h"
#import <unistd.h>
#define SCREENSHOT_MODE 0

#ifndef kCFCoreFoundationVersionNumber_iOS_8_0
#define kCFCoreFoundationVersionNumber_iOS_7_0 847.20
#endif

#pragma mark-------HomePage-----
#import "News_HomePageViewController.h"
#import "ImagePlayerView.h"
#import "UIImageView+WebCache.h"
#import "News_HomePageTableViewCell.h"
#import "News_ImagePlayerDetailViewController.h"
#import "News_HomePage.h"

#pragma mark-----an niu lie biao----
#import "BYListBar.h"
#import "BYArrow.h"
#import "BYDetailsList.h"
#import "BYDeleteBar.h"
#import "BYScroller.h"

#define kListBarH 30
#define kArrowW 40
#define kAnimationTime 0.8

#pragma mark------下拉刷新-------------
#import "MJRefresh.h"

#pragma mark-------AFNetWorking-------
//#import "AFNetworking.h"



@interface News_HomePageViewController () <UIScrollViewDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    long long expectedLength;
    long long currentLength;
    
    CGFloat contentOffSet;
}

@end

@implementation News_HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 2;

    NSUserDefaults * listDefaults = [NSUserDefaults standardUserDefaults];
    self.topArray =[[NSMutableArray alloc]initWithArray:[listDefaults objectForKey:@"listTop"]];
    self.bottomArray = [[NSMutableArray alloc]initWithArray:[listDefaults objectForKey:@"listBottom"]];
    

    [self setupNaviBar];
    [self makeContent];
    [self addFooter];
    [self addHeader];
    
    #pragma mark------------解析数据,并赋值给Model类---------------
    self.requestHandel = [[RequestHandle alloc]initWithUrlString:HomePageUrl paramUrl:nil method:@"GET" delegate:self];
    
}
- (void)setRequestHandle:(RequestHandle *)requestHandle requestSuccessData:(NSData *)successData
{
    if (!successData) {
        return;
    }
    NSDictionary  * dic = [NSJSONSerialization JSONObjectWithData:successData options:NSJSONReadingMutableContainers error:nil];
    self.allNewsArray = [NSMutableArray array];
    self.topArticleArray = [NSMutableArray array];
    self.focusArray = [NSMutableArray array];
    NSArray * array = dic[@"articleList"];
    for (NSDictionary * dict in array) {
        News_HomePage * newsHomePage = [[News_HomePage alloc]init];
        [newsHomePage setValuesForKeysWithDictionary:dict];
        [_allNewsArray addObject:newsHomePage];
    }
    NSArray * focusArray = dic[@"focus"];
    for (NSDictionary * dict in focusArray) {
        News_HomePage * newsHomePage = [[News_HomePage alloc]init];
        [newsHomePage setValuesForKeysWithDictionary:dict];
        [_focusArray addObject:newsHomePage];
    }
    NSArray * topFocusArray = dic[@"topFocus"];
    for (NSDictionary * dict in topFocusArray) {
        News_HomePage * newsHomePage = [[News_HomePage alloc]init];
        [newsHomePage setValuesForKeysWithDictionary:dict];
        [_topArticleArray addObject:newsHomePage];
    }
    [_allNewsArray addObjectsFromArray:_topArticleArray];
    [_allNewsArray addObjectsFromArray:_focusArray];
    [self.tableView reloadData];
    
}

#pragma mark--------------------下拉刷新方法-----------------------------
- (void)addHeader
{
    __block News_HomePageViewController *controller = self;
    
    // 添加下拉刷新头部控件
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        
        // 进入刷新状态就会回调这个Block
    controller.requestHandel = [[RequestHandle alloc]initWithUrlString:HomePageUrl
                                                              paramUrl:nil
                                                                method:@"GET"
                                                              delegate:controller];
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [controller.tableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [controller.tableView.header endRefreshing];
        });
    }];
    //#warning 自动刷新(一进入程序就下拉刷新)

        [controller.tableView.header beginRefreshing];
    
}
-(void)addFooter
{
    
    __block News_HomePageViewController *controller = self;
    // 添加上拉刷新尾部控件
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        // 进入刷新状态就会回调这个Block
        NSString * str = @"http://mrobot.pconline.com.cn/v2/cms/channels/1?pageNo=1&pageSize=20";
        // 1.添加假数据
        NSString*page=[NSString stringWithFormat:@"pageNo=%d",controller.count];
        NSString*newStr=[str stringByReplacingOccurrencesOfString:@"pageNo=1" withString:page];
        
        NSURL * url = [NSURL URLWithString:newStr];
        
        NSData * data = [NSData dataWithContentsOfURL:url];
        if (!data) {
            return ;
        }
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"articleList"];
        for (NSDictionary * dict in array) {
            News_HomePage * newsHomePage = [[News_HomePage alloc]init];
            [newsHomePage setValuesForKeysWithDictionary:dict];
            [controller.allNewsArray addObject:newsHomePage];
        }
        [controller.buttonDetailTVC.allDetailArray addObjectsFromArray:controller.newsArray];
        
        controller.count++;
        // 2.2秒后刷新表格UI
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [controller.tableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [controller.tableView.footer endRefreshing];
            
        });
    }];
    
}
#pragma mark--------------------------------------滑动块------------------------------------------------
- (void)setupNaviBar
{
    [self.navigationController.navigationBar setTranslucent:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)makeContent
{
    NSUserDefaults *listDefaults = [NSUserDefaults standardUserDefaults] ;
    [listDefaults setObject:_topArray forKey:@"listTop"];
    [listDefaults setObject:_bottomArray forKey:@"listBottom"];
    [listDefaults synchronize];

    self.listTop = [[NSMutableArray alloc]initWithArray:[listDefaults objectForKey:@"listTop"]];
    self.listBottom = [[NSMutableArray alloc]initWithArray:[listDefaults objectForKey:@"listBottom"]];

    __strong typeof(self) unself = self;
    if (!self.detailsList) {
        self.detailsList = [[BYDetailsList alloc]initWithFrame:CGRectMake(0, kListBarH-kScreenH, kScreenW, kScreenH-kListBarH)];
        self.detailsList.listAll = [NSMutableArray arrayWithObjects:_listTop,_listBottom,nil];
        self.detailsList.longPressedBlock = ^(){
            [unself.deleteBar sortBtnClick:unself.deleteBar.sortBtn];
        };
        self.detailsList.opertionFromItemBlock = ^(animateType type, NSString *itemName,int index){
            [unself.listBar operationFromBlock:type itemName:itemName index:index];
            unself.mainScroller.contentSize = CGSizeMake(kScreenW*unself.detailsList.topView.count,unself.mainScroller.frame.size.height);
        };
        [self.view addSubview:self.detailsList];
        News_ButtonDetailTableViewController * buttonVC = [[News_ButtonDetailTableViewController alloc]init];
        buttonVC.buttonIndex = self.buttonIndex;
        
    }
    if (!self.listBar) {
        self.listBar = [[BYListBar alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kListBarH)];
        
        self.listBar.homeController = self;
        self.listBar.visibleItemList = _listTop;
        self.listBar.arrowChange = ^(){
            if (unself.arrow.arrowBtnClick) {
                unself.arrow.arrowBtnClick();
                
                
            }
        };
        self.listBar.listBarItemClickBlock = ^(NSString *itemName , NSInteger itemIndex){
            [unself.detailsList itemRespondFromListBarClickWithItemName:itemName];
            //设置scrollview偏移量
            
            //移动到该位置
            if (itemIndex != unself.listTop.count) {
                unself.mainScroller.contentOffset =  CGPointMake(itemIndex * unself.mainScroller.frame.size.width, 0);
            }else{
                unself.mainScroller.contentOffset = CGPointMake(0, 0);
            }
            
            unself.listBar.itemName = itemName;
            unself.listBar.buttonIndex = itemIndex;
            unself.buttonIndex = itemIndex;
            unself.listBar.listTop = unself.listTop.count;
            
        };
        
        [self.view addSubview:self.listBar];
    }
    
    if (!self.deleteBar) {
        self.deleteBar = [[BYDeleteBar alloc] initWithFrame:self.listBar.frame];
        [self.view addSubview:self.deleteBar];
    }
    
    
    if (!self.arrow) {
        self.arrow = [[BYArrow alloc] initWithFrame:CGRectMake(kScreenW-kArrowW, 0, kArrowW, kListBarH)];
        self.arrow.arrowBtnClick = ^(){
            unself.deleteBar.hidden = !unself.deleteBar.hidden;
            
            
            [UIView animateWithDuration:kAnimationTime animations:^{
                CGAffineTransform rotation = unself.arrow.imageView.transform;
                unself.arrow.imageView.transform = CGAffineTransformRotate(rotation,M_PI);
                unself.detailsList.transform = (unself.detailsList.frame.origin.y<0)?CGAffineTransformMakeTranslation(0, kScreenH):CGAffineTransformMakeTranslation(0, -kScreenH);
            }];
        };
        [self.view addSubview:self.arrow];
    }
    
    if (!self.mainScroller) {
        self.mainScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kListBarH, kScreenW , kScreenH-kListBarH-64)];
        self.mainScroller.tag = 1;//tag
        self.mainScroller.bounces = NO;
        self.mainScroller.pagingEnabled = YES;
        self.mainScroller.showsHorizontalScrollIndicator = NO;
        self.mainScroller.showsVerticalScrollIndicator = NO;
        self.mainScroller.delegate = self;
        //设置scrollView的contantView大小
        self.mainScroller.contentSize = CGSizeMake(kScreenW*self.detailsList.topView.count,self.mainScroller.frame.size.height);
        [self.view insertSubview:self.mainScroller atIndex:0];
        //添加一个scrollView的方法
        [self addScrollViewWithItemName:@"推荐" index:0];

//        [self addScrollViewWithItemName:@"测试" index:1];
    }
}
-(void)addScrollViewWithItemName:(NSString *)itemName index:(NSInteger)index{
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-143) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.mainScroller addSubview:_tableView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    //没滑过去不创建新的tableView
    if (scrollView.contentOffset.x == contentOffSet)
    {
        contentOffSet = scrollView.contentOffset.x;
        return;
    }
    contentOffSet = scrollView.contentOffset.x;
    [self.listBar itemClickByScrollerWithIndex:scrollView.contentOffset.x / self.mainScroller.frame.size.width];
    
    if (scrollView.tag == 1 && _buttonIndex != 0 ) {
        News_ButtonDetailTableViewController * buttonDetailTableVC = [[News_ButtonDetailTableViewController alloc] init];
        buttonDetailTableVC.listBar = self.listBar;
        
        buttonDetailTableVC.tableView.frame = CGRectMake(ViewWidth*_buttonIndex, 0, ViewWidth, ViewHeight-143);
        //保持持有 将VC添加到父视图的VC子类中  否则VC会释放 tableView没有了VC也将不存在
        [self addChildViewController:buttonDetailTableVC];
        [self.mainScroller addSubview:buttonDetailTableVC.tableView];
        
        
        NSDictionary * buttonDetailUrlDic = @{@"相机":CameraUrl,@"平板":PPCUrl,@"行情":CaseUrl,@"摄像机":VidiconUrl,@"超极本":SuperPCUrl,@"电视":TVUrl,@"DIY":DIYUrl,@"家电":HouseUrl,@"iPhone":IphoneUrl,@"新闻":NewsUrl};
        NSString * str = buttonDetailUrlDic[self.listBar.itemName];
        NSURL * url = [NSURL URLWithString:str];
        if (_buttonIndex == 0) {
            url = [NSURL URLWithString:HomePageUrl];
        }
        NSData * data = [NSData dataWithContentsOfURL:url];
        if (!data) {
            return;
        }
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.newsArray = [NSMutableArray array];
        NSArray * array = dic[@"articleList"];
        for (NSDictionary * dict in array) {
            News_HomePage * newsHomePage = [[News_HomePage alloc]init];
            [newsHomePage setValuesForKeysWithDictionary:dict];
            [_newsArray addObject:newsHomePage];
        }
        buttonDetailTableVC.allDetailArray = [NSMutableArray arrayWithArray:_newsArray];

        buttonDetailTableVC.scrollView = scrollView;
    }
}



#pragma mark-----------------------tableView------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allNewsArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 200;
    }else{
        return 80;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ImagePlayer"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ImagePlayer"];
        }
#pragma mark---------------------轮播图---------------------------------
        self.imagePlayerView = [[ImagePlayerView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 200)];
//        _imagePlayerView.clipsToBounds = YES;//剪切边
        _imagePlayerView.imagePlayerViewDelegate = self;
        _imagePlayerView.scrollInterval = 2.0f;
        //pageControl位置
        _imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
        _imagePlayerView.hidePageControl = NO;
        [_imagePlayerView reloadData];
        [cell.contentView addSubview:_imagePlayerView];
        return cell;
    }else{
        News_HomePageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[News_HomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        News_HomePage * newsHomePage = _allNewsArray[indexPath.row];
        cell.newsHomePage = newsHomePage;
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_ImagePlayerDetailViewController * imagePlayerDetailVC = [[News_ImagePlayerDetailViewController alloc]init];
    News_HomePage * newsHomePage = [[News_HomePage alloc]init];
    newsHomePage = _allNewsArray[indexPath.row];
    imagePlayerDetailVC.detailPageUrl = newsHomePage.url;
    UINavigationController * imageNav = [[UINavigationController alloc]initWithRootViewController:imagePlayerDetailVC];
    [self.navigationController presentViewController:imageNav animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark------------------轮播图方法--------------------------------
- (NSInteger)numberOfItems
{
    return _focusArray.count;
}
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    News_HomePage * newsHomePage = [[News_HomePage alloc]init];
    newsHomePage = _focusArray[index];
    NSURL * imageUrl = [NSURL URLWithString:newsHomePage.image];
    [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"picholder"]];
}
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    News_ImagePlayerDetailViewController * imagePlayerDetailVC = [[News_ImagePlayerDetailViewController alloc]init];
    News_HomePage * newsHomePage = [[News_HomePage alloc]init];
    newsHomePage = _focusArray[index];
    imagePlayerDetailVC.detailPageUrl = newsHomePage.url;
    UINavigationController * DetNav = [[UINavigationController alloc]initWithRootViewController:imagePlayerDetailVC];
    [self.navigationController presentViewController:DetNav animated:YES completion:^{
        
    }];
}
- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
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
