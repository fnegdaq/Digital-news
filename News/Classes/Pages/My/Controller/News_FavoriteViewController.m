//
//  News_FavoriteViewController.m
//  News
//
//  Created by fengdaq on 15/3/24.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_FavoriteViewController.h"
#import "DataBaseHandle.h"
#import "News_ProductDetailViewController.h"

@interface News_FavoriteViewController ()

@property (retain, nonatomic) NSMutableArray *array;

@end

@implementation News_FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;


    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    self.array = [NSMutableArray array];
    _array = [[DataBaseHandle shareInstance]queryAllProduct];
    NSLog(@"%@",_array);
    if (_array.count == 0)
    {
        [self creatFavoNilView];
    }
    
    return [_array count];
}

- (void)creatFavoNilView
{
    UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    oneView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth*.2, ViewHeight*.1, ViewWidth*.6, ViewWidth*.6)];
    imageView.image = [UIImage imageNamed:@"hehe123"];
    
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*.2, ViewWidth*.6+ViewHeight*.2, ViewWidth*.6, 40)];
    oneLabel.text = @"亲~还没有收藏哦~";
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont systemFontOfSize:18.0];
    
    [oneView addSubview:oneLabel];
    [oneView addSubview:imageView];
    [self.view addSubview:oneView];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *favo = @"favo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:favo];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:favo];
    }
    // Configure the cell...
    cell.textLabel.text = [_array[indexPath.row] objectForKey:@"ProductName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_ProductDetailViewController *detailVC = [[News_ProductDetailViewController alloc]init];
    NSDictionary *dic = _array[indexPath.row];
    
    detailVC.proName = dic[@"ProductName"];
    detailVC.proId = dic[@"ProId"];
    detailVC.seriesId = dic[@"SeriesId"];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

//允许tableView可被编辑
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //同步更新UI和数据
        [self.tableView beginUpdates];//************************
        
        NSDictionary *dic = _array[indexPath.row];
       [[DataBaseHandle shareInstance]deleteProductByName:dic[@"ProductName"]];
        
        //②删除UI
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        [self.tableView endUpdates];//****************************
    }
}


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
