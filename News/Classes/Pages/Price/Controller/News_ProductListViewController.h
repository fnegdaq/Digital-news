//
//  News_ProductListViewController.h
//  News
//
//  Created by fengdaq on 15/3/13.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface News_ProductListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


- (id)initWithUrl:(NSString *)url;

@property (copy, nonatomic) NSString *orderBy; //排列方式 热门:1 最新:14 价高:4 价低:3
@property (copy, nonatomic) NSString *subcateId; //子类id
@property (copy, nonatomic) NSString *manuId; //品牌id
@property (copy, nonatomic) NSString *seriesId; //种类id

@property (copy, nonatomic) NSString *titleName;

@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *keyValue; //接受搜索传来的关键字
@property (retain, nonatomic) UIButton *navRightButton;

- (void)analysisData;

@end
