//
//  News_DetailViewController.h
//  News
//
//  Created by fengdaq on 15/3/14.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DetailPicture.h"
@class News_PictureTableViewController;
@interface News_DetailViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,retain)UIScrollView *containScrollView;

@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *pageLabel;
@property (nonatomic,retain)UITextView *contentsTextView;

@property (nonatomic,copy)NSString * newsTitle;
@property (nonatomic,assign)int num;

@property (nonatomic,retain)DetailPicture *detailPic;

@property (nonatomic,copy)NSString *urlid;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,retain)UIImageView *imageview;
@property (nonatomic,retain)UIScrollView *smallScrollView;
@property (nonatomic,assign)int count;
@property (nonatomic,assign)int comCount;
@property (nonatomic,copy)NSString * comId;
@end
