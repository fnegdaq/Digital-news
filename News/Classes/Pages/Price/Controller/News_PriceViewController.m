//
//  News_PriceViewController.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_PriceViewController.h"
#import "News_LargeClassifyViewController.h"
#import "News_SmallClassifyViewController.h"
#import "News_ProductSearchViewController.h"
@interface News_PriceViewController ()

@property (retain, nonatomic) News_LargeClassifyViewController *largeTableView;
@property (retain, nonatomic) News_SmallClassifyViewController *smallTableView;

@end

@implementation News_PriceViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"产品查询";
    
    
    self.largeTableView = [[News_LargeClassifyViewController alloc]init];
    self.smallTableView = [[News_SmallClassifyViewController alloc]init];
    
    self.tabBarController.tabBar.hidden = NO ;

    /**
     *  这里添加子控件,为了在SmallTableViewController中 didSelect push到ProductViewController
     */
    [self addChildViewController:_smallTableView];

    
    _largeTableView.delegate = _smallTableView;
    
    
    [self.view addSubview:_largeTableView.tableView];
    [self.view addSubview:_smallTableView.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                            target:self
                            action:@selector(didClickToSearch)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
        
}

- (void)didClickToSearch
{
    News_ProductSearchViewController *search = [[News_ProductSearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
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
