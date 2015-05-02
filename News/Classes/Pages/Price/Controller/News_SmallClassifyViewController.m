//
//  News_SmallClassifyViewController.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#define SmallIdentifier @"SamllClassifyCell"

#import "News_SmallClassifyViewController.h"
#import "News_SmallClassifyViewCell.h"
#import "News_SmallClassifyModel.h"
#import "News_ProductListViewController.h"
#import "MBProgressHUD.h"

@interface News_SmallClassifyViewController ()

@property (retain, nonatomic) MBProgressHUD *hud;
@property (retain, nonatomic) NSMutableArray *sourceArray;

@end

@implementation News_SmallClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(ViewWidth*0.35, 0, ViewWidth*0.65, ViewHeight);
    [self.tableView registerClass:[News_SmallClassifyViewCell class] forCellReuseIdentifier:SmallIdentifier];
    
    //cell分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor colorWithWhite:0.91 alpha:1];
    //是否显示垂直轮动条
    self.tableView.showsVerticalScrollIndicator = YES;
    
    self.clearsSelectionOnViewWillAppear = YES;
   
    //self.tableView.delegate = self;
    
    self.subId = @"57";
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
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}

- (void)analysisData
{
    
    NSString *UrlPath = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_Manu&noParam=1&subcateId=%@&vs=iph370&interfaceVersion=1",self.subId];
    
    [[RequestHandle alloc]initWithUrlString:UrlPath paramUrl:nil method:@"GET" delegate:self];
}

/**
 *  实现协议方法,接受传来的subId
 *
 *  @param subId
 */
- (void)sendSubIdToSmallClassify:(NSString *)subId
{
    
    self.subId = subId;
    
    [self setupProgressHud];
    [self analysisData];
}


- (void)setRequestHandle:(RequestHandle *)requestHandle requestSuccessData:(NSData *)successData
{
    //隐藏菊花
    [_hud hide:YES];
    if (!successData) {
        return;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:successData options:NSJSONReadingMutableContainers error:nil];
    
    
    self.afreshGroupDic = [[NSMutableDictionary alloc]initWithCapacity:60];
   // self.brandIdArr = [NSMutableArray array];
   
    NSArray *brandArray = dic[@"brandList"];
   // NSMutableArray *indexName = [NSMutableArray array];
    for (NSDictionary *indexDic in brandArray) {
        NSString *string = indexDic[@"index"];
        
        NSMutableArray *modelArray = [NSMutableArray array];
        NSArray *array = indexDic[@"manuArr"];
        for (NSDictionary *dic in array) {
            News_SmallClassifyModel *smallModel = [[News_SmallClassifyModel alloc]init];
            [smallModel setValuesForKeysWithDictionary:dic];
            [modelArray addObject:smallModel];
            
        }
        [_afreshGroupDic setObject:modelArray forKey:string];
        
    }
    /**
     *  先排序 后刷新
     */
    self.sortGroupKey = [NSMutableArray arrayWithArray:_afreshGroupDic.allKeys];
    [self.sortGroupKey sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
        
    }];
    [self.sortGroupKey insertObject:[_sortGroupKey lastObject] atIndex:0];
    [_sortGroupKey removeLastObject];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _sortGroupKey.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[_afreshGroupDic objectForKey:[_sortGroupKey objectAtIndex:section]] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _sortGroupKey[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 40;
//    }else{
    return 20;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _sortGroupKey;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    News_SmallClassifyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SmallIdentifier forIndexPath:indexPath];
  
    NSString *key = _sortGroupKey[indexPath.section];
    NSArray *array = _afreshGroupDic[key];
    News_SmallClassifyModel *smallClassify = array[indexPath.row];
    cell.samllClassify = smallClassify;
    
    
    return cell;
}

/**
 *  解决点击largeClassfiy某个菊花在跑的cell时,再点击别的largeClassfiy,菊花还在的问题
 */
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_hud hide:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    News_ProductListViewController *produceList = [[News_ProductListViewController alloc]init];
    produceList.subcateId = _subId;
   // produceList.manuId = _brandIdArr[indexPath.row];
    
    produceList.manuId = [[[_afreshGroupDic objectForKey:[_sortGroupKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] ID];
    
    produceList.titleName = [[[_afreshGroupDic objectForKey:[_sortGroupKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] name];
    
    [self.navigationController pushViewController:produceList animated:YES];
    
   // produceList.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self.navigationController presentViewController:produceList animated:YES completion:^{
    
//    }];
    
}


@end
