//
//  News_ButtonDetailTableViewCell.h
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "News_HomePage.h"
@interface News_ButtonDetailTableViewCell : UITableViewCell
@property (nonatomic,retain)UIImageView * newsImageView;
@property (nonatomic,retain)UILabel * titleLabel;
@property (nonatomic,retain)UILabel * timeLabel;
@property (nonatomic,retain)UILabel * commentLabel;
@property (nonatomic,retain)News_HomePage * newsHomePage;

@end
