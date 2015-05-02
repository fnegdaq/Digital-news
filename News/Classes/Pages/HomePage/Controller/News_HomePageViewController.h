//
//  News_HomePageViewController.h
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView.h"
#import "RequestHandle.h"
@class BYListBar;
#import "BYArrow.h"
#import "BYDetailsList.h"
#import "BYDeleteBar.h"
#import "BYScroller.h"
#import <CoreData/CoreData.h>
@class BYListItem;
#import "News_ButtonDetailTableViewController.h"

@interface News_HomePageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ImagePlayerViewDelegate,RequestHandleDelegate>

@property (nonatomic,retain)ImagePlayerView * imagePlayerView;
@property (nonatomic,retain)NSMutableArray * urlArray;
@property (nonatomic) BYListBar *listBar;           //列表条UIScrollView
@property (nonatomic,strong) BYDeleteBar *deleteBar;       //删除条UIView
@property (nonatomic,strong) BYDetailsList *detailsList;   //详情列表UIScrollView
@property (nonatomic,strong) BYArrow *arrow;               //箭头UIButton
@property (nonatomic,strong) UIScrollView *mainScroller;   //主滚动条
@property (nonatomic,retain) RequestHandle * requestHandel;
@property (nonatomic,retain) NSMutableArray * focusArray;  //轮播图数组
@property (nonatomic,retain) NSMutableArray * topArticleArray;//置顶新闻数组
@property (nonatomic,retain) NSMutableArray * allNewsArray;
@property (nonatomic,retain) UITableView * tableView;
@property (nonatomic,assign) NSInteger buttonIndex;
@property (nonatomic,retain) News_ButtonDetailTableViewController * buttonDetailTVC;
@property (nonatomic,retain) NSString * itemName;
@property (nonatomic,retain) NSMutableArray * newsArray;//滑动块url解析出的数组
@property (nonatomic,retain) NSMutableArray * listTop;//顶部滑动块名称数组
@property (nonatomic,retain) NSMutableArray * listBottom;//下部滑动块名称数组
@property (nonatomic,assign) int count;//刷新页面page页数
@property (nonatomic,assign) NSInteger beginIndex;
@property (nonatomic,assign) NSInteger endIndex;
@property (nonatomic,retain) BYListItem * byListItem;
@property (nonatomic,assign) NSInteger buttonCount;
@property (nonatomic,retain) NSUserDefaults * listDefaults;
@property (nonatomic,assign) int listTopCount;
@property (nonatomic,strong)NSMutableArray * topArray;
@property (nonatomic,strong)NSMutableArray * bottomArray;

@end
