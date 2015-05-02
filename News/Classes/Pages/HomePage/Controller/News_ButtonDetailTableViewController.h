//
//  News_ButtonDetailTableViewController.h
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYListBar.h"
@interface News_ButtonDetailTableViewController : UITableViewController
@property (nonatomic,retain)NSMutableArray * allDetailArray;
@property (nonatomic) BYListBar *listBar;
@property (nonatomic,retain) NSString * itemName;
@property (nonatomic,retain) NSMutableArray * newsArray;//滑动块url解析出的数组
@property (nonatomic,assign) int count;
@property (nonatomic,retain) UIScrollView * scrollView;
@property (nonatomic,assign) NSInteger buttonIndex;
@property (nonatomic,copy)NSString * buttonDetailUrl;
@end
