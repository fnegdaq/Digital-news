//
//  News_ProductDetailPhotoViewController.m
//  News
//
//  Created by fengdaq on 15/3/18.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_ProductDetailPhotoViewController.h"
#import "News_ProductPhotoModel.h"
#import "News_PDetailPhotoView.h"
#import "AFNetworking.h"

@interface News_ProductDetailPhotoViewController ()
{
    News_PDetailPhotoView * photoGroup;
}
@property (nonatomic, strong) NSMutableArray *srcStringArray;
@property (retain, nonatomic) UITableView *tableView;
@end

@implementation News_ProductDetailPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-64) style:UITableViewStylePlain];
    
    self.title = @"图片";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self analysisData];
}

- (void)viewWillappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)analysisData
{
    NSString *path = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?&c=Iphone_37o_ProPics&noParam=1&proId=%@&seriesId=%@",self.proId,self.seriesId];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
   
    __weak typeof(self) wealSelf = self;
    [manager GET:path
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *array = (NSArray *)responseObject;
        wealSelf.srcStringArray = [NSMutableArray array];
        for (NSDictionary *dic in array)
        {
            [_srcStringArray addObject:dic[@"picSrc"]];
        }
        [wealSelf.tableView reloadData];
        
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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return photoGroup.cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *photo = @"photo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:photo];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:photo];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    photoGroup = [[News_PDetailPhotoView alloc] init];
    
    NSMutableArray *temp = [NSMutableArray array];
    [_srcStringArray enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
        News_ProductPhotoModel *item = [[News_ProductPhotoModel alloc] init];
        item.picSrc = src;
        [temp addObject:item];
    }];
    
    photoGroup.photoItemArray = [temp copy];
    [cell.contentView addSubview:photoGroup];
    
    return cell;
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
