//
//  News_ProductDetailConfigViewController.m
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_ProductDetailConfigViewController.h"
#import "News_PDetailConfigViewCell.h"
#import "UITableViewCell+TextHeight.h"

@interface News_ProductDetailConfigViewController ()

@property (retain, nonatomic) NSMutableDictionary *allConfigDic;
@property (retain, nonatomic) NSMutableArray *allKeyArray;
@property (retain, nonatomic) UITableView *tableView;

@end

@implementation News_ProductDetailConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-64) style:UITableViewStylePlain];
    
    self.title = @"详细配置";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self analysisData];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}


- (void)analysisData
{
    NSString *urlPath = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_ProParam&proId=%@",self.proId];
    [[RequestHandle alloc]initWithUrlString:urlPath
                                   paramUrl:nil
                                     method:@"GET"
                                   delegate:self];
}

- (void)setRequestHandle:(RequestHandle *)requestHandle requestSuccessData:(NSData *)successData
{
    NSArray *array = [NSJSONSerialization JSONObjectWithData:successData
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
    
    self.allConfigDic = [NSMutableDictionary dictionary];
   
    for (NSDictionary *dic in array) {
        NSString *nameString = dic[@"name"];
        
        NSMutableArray *valueArray = [NSMutableArray array];  //写第一个for循环外--->每个section中都是全部的信息了...
        NSMutableArray *oneArray = dic[@"paramArr"];
        for (NSMutableDictionary *dicc in oneArray) {
           
            [dicc removeObjectForKey:@"id"];
            
            News_ProductDetailModel *configModel = [[News_ProductDetailModel alloc]init];
            [configModel setValuesForKeysWithDictionary:dicc];
            [valueArray addObject:configModel];
        }
        [self.allConfigDic setObject:valueArray forKey:nameString];
    }
    
    self.allKeyArray = [NSMutableArray arrayWithArray:_allConfigDic.allKeys];
    [_allKeyArray removeObject:@"基本参数"];
    [self.allKeyArray insertObject:@"基本参数" atIndex:0];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _allKeyArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *key = _allKeyArray[section];
    
    return [_allConfigDic[key] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _allKeyArray[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *key = _allKeyArray[indexPath.section];
    NSArray *array = _allConfigDic[key];
    
    CGFloat height1 = [News_PDetailConfigViewCell getText:[array[indexPath.row] name] FontSize:15.0 Width:(ViewWidth)/3-15];
    
    CGFloat height2 =[News_PDetailConfigViewCell getText:[array[indexPath.row] configValue] FontSize:15.0 Width:ViewWidth/3.0*2-20];
    
    return height1+height2;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
   
    News_PDetailConfigViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[News_PDetailConfigViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    NSString *key = _allKeyArray[indexPath.section];
    NSArray *array = _allConfigDic[key];
    News_ProductDetailModel *proModel = array[indexPath.row];
    cell.productDetail = proModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


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
