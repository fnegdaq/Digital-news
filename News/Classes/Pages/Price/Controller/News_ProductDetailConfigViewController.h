//
//  News_ProductDetailConfigViewController.h
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestHandle.h"
@interface News_ProductDetailConfigViewController : UIViewController<RequestHandleDelegate,UITableViewDataSource,UITableViewDelegate>

@property (copy, nonatomic) NSString *proId;

@end
