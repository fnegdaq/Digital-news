//
//  News_PictureTableViewController.m
//  News
//
//  Created by fengdaq on 15/3/14.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_PictureTableViewController.h"
#import "PictureTableViewCell.h"
#import "PictureData.h"
#import "News_DetailViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "News_CommentsViewController.h"

@interface News_PictureTableViewController ()
@property(nonatomic,retain)NSMutableArray * urlIdArray;//网址ID


@end

@implementation News_PictureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.count = 2;
    self.title = @"图赏";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -40, ViewWidth, ViewHeight+10) style:UITableViewStylePlain];

    //设置tableView分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSURL *url=[NSURL URLWithString:PictureUrl];
    NSData *data=[NSData dataWithContentsOfURL:url];
    if (!data) {
        return;
    }
    NSDictionary *dic=  [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableContainers error:nil];
    self.urlIdArray=[NSMutableArray array];
    self.mulArray=[NSMutableArray array];
    NSArray *array=[dic objectForKey:@"list"];
   
    for (NSDictionary *dict in array) {
        
        PictureData *pict=[[PictureData alloc]init];
        [pict setValuesForKeysWithDictionary:dict];
        pict.comId = dict[@"id"];
        [_mulArray addObject:pict];

        
        [_urlIdArray addObject:[dict objectForKey:@"id"]];
    }
    [self setupRefresh];
    
    [self.tableView reloadData];
   
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
  //  [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
   // [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.
    [_mulArray removeAllObjects];
    self.url=[NSURL URLWithString:@"http://lib.wap.zol.com.cn/ipj/tushang.php?page=1&retina=1&vs=iph382"];
    [self analysisData];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView.header endRefreshing];
    });
}

- (void)footerRereshing
{
//     1.
    self.url=[NSURL URLWithString:[NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/tushang.php?page=%d&retina=1&vs=iph382",_count]];
    [self analysisData];
    self.count ++;
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView .footer endRefreshing];
    });
    
    
        
}
- (void)analysisData
{
    NSURLRequest *request=[NSURLRequest requestWithURL:_url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (!data) {
        return;
    }
    NSMutableDictionary *dic=[NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers error:nil];
    NSArray *array= [NSArray array];
    array =[dic objectForKey:@"list"];
    for (NSDictionary *dataDic in array) {
        PictureData *picData=[PictureData new];
        [picData setValuesForKeysWithDictionary:dataDic];
        [_mulArray addObject:picData];
        [_urlIdArray addObject:[dataDic objectForKey:@"id"]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _mulArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PictureTableViewCell * picCell =[tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!picCell) {
        picCell=[[PictureTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
        //picCell.backgroundColor = [UIColor redColor];
    picCell.selectionStyle = UITableViewCellSelectionStyleNone;
    picCell.index = indexPath.row;
    picCell.pic=[_mulArray objectAtIndex:indexPath.row];
    return picCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_DetailViewController *detailVC=[[News_DetailViewController alloc]init];
    detailVC.urlid=_urlIdArray[indexPath.row];
    
    PictureData * pic = _mulArray[indexPath.row];
    detailVC.newsTitle=pic.title;
    detailVC.num=pic.num;
    detailVC.comCount = pic.comNum;
    detailVC.comId = pic.comId;
    [self.navigationController presentViewController:detailVC animated:YES completion:^{
        
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
