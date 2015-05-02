//
//  News_ProductDetailViewController.h
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestHandle.h"
@interface News_ProductDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,RequestHandleDelegate>

@property (copy, nonatomic) NSString *proName;
@property (copy, nonatomic) NSString *seriesId;
@property (copy, nonatomic) NSString *proId;
//@property (copy, nonatomic) UIButton *rightBtn;

@end
