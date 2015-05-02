//
//  News_LargeClassifyViewCell.h
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News_LargeClassifyModel.h"

@interface News_LargeClassifyViewCell : UITableViewCell

@property (retain, nonatomic) UILabel *titleLabel;
@property (copy ,nonatomic) NSString *subIdString;  //用于接受subId

@property (retain, nonatomic) News_LargeClassifyModel *largeCM;

@end
