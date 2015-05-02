//
//  News_PictureTableViewController.h
//  News
//
//  Created by fengdaq on 15/3/14.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureData.h"
@interface News_PictureTableViewController : UITableViewController

@property (nonatomic,retain)NSMutableArray *mulArray;

@property (nonatomic,retain)NSURL *url;
@property (nonatomic,retain)PictureData *picData;
@property (nonatomic,assign)int count;


@end
