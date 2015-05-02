//
//  News_ProductSearchViewController.m
//  News
//
//  Created by fengdaq on 15/3/23.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_ProductSearchViewController.h"

@interface News_ProductSearchViewController ()<UITextFieldDelegate,UISearchBarDelegate>

@property (retain,nonatomic) UISearchBar *searchBar;

@end

@implementation News_ProductSearchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [_searchBar becomeFirstResponder];
    [self.navRightButton removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES ;
}

- (void)viewDidLoad {
    //[super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 200, 35)];
    _searchBar.placeholder = @"输入关键词";
    _searchBar.delegate = self;
   // _searchBar.keyboardType = UIKeyboardTypeWebSearch;
    _searchBar.tintColor=[UIColor grayColor];
    
    self.navigationItem.titleView = _searchBar;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    NSString *string = @"http://lib3.wap.zol.com.cn/index.php?c=Iphone_391_List&noParam=1&num=20&keyword=";
//    self.url = [string stringByAppendingString:[_searchBar.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_searchBar resignFirstResponder];
    
    self.keyValue = [_searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [super viewDidLoad];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
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
