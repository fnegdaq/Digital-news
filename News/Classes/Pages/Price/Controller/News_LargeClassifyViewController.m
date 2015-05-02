//
//  News_LargeClassifyViewController.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#define LargeIdentifier @"largeClassifyCell"

#import "News_LargeClassifyViewController.h"
#import "News_LargeClassifyViewCell.h"
#import "News_LargeClassifyModel.h"
#import "News_SmallClassifyViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface News_LargeClassifyViewController ()
@property (retain, nonatomic) MBProgressHUD *hud;
@property (retain ,nonatomic) NSMutableArray *allLargeClassifyArray;
@property (retain, nonatomic) NSIndexPath *selectedIndexPath; //防止largeClassify 重复点击 smallClassify重复刷新
@end

@implementation News_LargeClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 0, ViewWidth*0.35, ViewHeight);
    //cell分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor colorWithWhite:0.91 alpha:1];
    //是否显示垂直轮动条
    self.tableView.showsVerticalScrollIndicator = NO;
 
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
   
    [self setupProgressHud];
    [self analysisData];
}

- (void)setupProgressHud
{
    if (_hud) {
        [_hud removeFromSuperview];
    }
    self.hud = [[MBProgressHUD alloc] initWithView:self.view] ;
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(50, 50);
    _hud.mode = MBProgressHUDModeIndeterminate;
    
    NSLog(@"%@",[self.tableView.superview class]);
    
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}
/**
 *  解析数据
 */
- (void)analysisData{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil]];
    
    [manager GET:PriceUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [_hud hide:YES];
        
        self.allLargeClassifyArray = [NSMutableArray array];
        NSArray *array = (NSArray*)responseObject;
             for (NSDictionary *dic in array)
             {
                 News_LargeClassifyModel *large = [[News_LargeClassifyModel alloc]init];
                 [large setValuesForKeysWithDictionary:dic];
                 [_allLargeClassifyArray addObject:large];
                 [self.tableView reloadData];
                 
                 //默认选中第一行
                 NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
                 [self.tableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionNone];
             }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
             NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [_allLargeClassifyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_LargeClassifyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LargeIdentifier];
    if (cell == nil) {
        cell = [[News_LargeClassifyViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LargeIdentifier];
    }
   
    /**
     *  拖动cell重用才remove ,下面重写方法 *1
     */
    if (!cell.selected) {
        UIView *selectView = [cell viewWithTag:1001];
        [selectView removeFromSuperview];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        cell.titleLabel.textColor = [UIColor blackColor];
     }
    
    News_LargeClassifyModel *largeModel = _allLargeClassifyArray[indexPath.row];
    cell.largeCM = largeModel;
    
    return cell;
}

// *1
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_LargeClassifyViewCell *cell = (News_LargeClassifyViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIView *selectView = [cell viewWithTag:1001];
    [selectView removeFromSuperview];
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    cell.titleLabel.textColor = [UIColor blackColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  和largeCell 选中的道理一样 防止重复点击 让smallClassify重复刷新 --->(BUG)菊花一直转..
     */
    if (indexPath.section == _selectedIndexPath.section && indexPath.row == _selectedIndexPath.row) {
        return;
    }
    self.selectedIndexPath = indexPath;
    
    NSString * string= [[_allLargeClassifyArray objectAtIndex:indexPath.row] subId];
    
    if ([_delegate respondsToSelector:@selector(sendSubIdToSmallClassify:)]) {
        [_delegate sendSubIdToSmallClassify:string];
    }
    
    //self.sendSubId(string);
   // NSLog(@"%@",string);
    
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
