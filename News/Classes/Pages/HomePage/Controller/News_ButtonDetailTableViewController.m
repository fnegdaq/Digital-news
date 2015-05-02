//
//  News_ButtonDetailTableViewController.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_ButtonDetailTableViewController.h"
#import "News_ButtonDetailTableViewCell.h"
#import "News_HomePage.h"
#import "BYListBar.h"
#import "News_ImagePlayerDetailViewController.h"


#pragma mark------下拉刷新-------------
#import "MJRefresh.h"



@interface News_ButtonDetailTableViewController ()

@end

@implementation News_ButtonDetailTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


    self.count = 2;
    [self addHeader];
    [self addFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--------------------下拉刷新方法-----------------------------
- (void)addHeader
{
    __block News_ButtonDetailTableViewController *controller = self;
    
    // 添加下拉刷新头部控件
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        

        if (controller.scrollView.tag == 1) {
        NSDictionary * buttonDetailUrlDic = @{@"相机":CameraUrl,@"平板":PPCUrl,@"行情":CaseUrl,@"摄像机":VidiconUrl,@"超极本":SuperPCUrl,@"电视":TVUrl,@"DIY":DIYUrl,@"家电":HouseUrl,@"iPhone":IphoneUrl,@"新闻":NewsUrl};
        NSString * str = buttonDetailUrlDic[controller.listBar.itemName];
        NSURL * url = [NSURL URLWithString:str];
            if (controller.buttonIndex == 0) {
                url = [NSURL URLWithString:HomePageUrl];
            }
        NSData * data = [NSData dataWithContentsOfURL:url];
            if (!data) {
                return ;
            }
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        controller.newsArray = [NSMutableArray array];
        NSArray * array = dic[@"articleList"];
        for (NSDictionary * dict in array) {
            News_HomePage * newsHomePage = [[News_HomePage alloc]init];
            [newsHomePage setValuesForKeysWithDictionary:dict];
            [controller.newsArray addObject:newsHomePage];
        }
        }
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
    
    __block News_ButtonDetailTableViewController *controller = self;
    // 添加上拉刷新尾部控件
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        // 进入刷新状态就会回调这个Block
        // 1.添加假数据
        NSDictionary * buttonDetailUrlDic = @{@"相机":CameraUrl,@"平板":PPCUrl,@"行情":CaseUrl,@"摄像机":VidiconUrl,@"超极本":SuperPCUrl,@"电视":TVUrl,@"DIY":DIYUrl,@"家电":HouseUrl,@"iPhone":IphoneUrl,@"新闻":NewsUrl};
        NSString * str = buttonDetailUrlDic[controller.listBar.itemName];
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
            [controller.allDetailArray addObject:newsHomePage];
        }
        [controller.allDetailArray addObjectsFromArray:controller.newsArray];
        
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _allDetailArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_ButtonDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buttonDetailCell"];
    if (!cell) {
        cell = [[News_ButtonDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"buttonDetailCell"];
    }
    
    // Configure the cell...
    News_HomePage * newsHomePage = _allDetailArray[indexPath.row];
    cell.newsHomePage = newsHomePage;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_ImagePlayerDetailViewController * imagePlayerDetailVC = [[News_ImagePlayerDetailViewController alloc]init];
    News_HomePage * newsHomePage = [[News_HomePage alloc]init];
    newsHomePage = _allDetailArray[indexPath.row];
    imagePlayerDetailVC.detailPageUrl = newsHomePage.url;
    UINavigationController * imageNav = [[UINavigationController alloc]initWithRootViewController:imagePlayerDetailVC];
    [self.navigationController presentViewController:imageNav animated:YES completion:^{
        
    }];
}

- (void)didClickedLeftBtn
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
