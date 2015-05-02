//
//  PictureTableViewCell.h
//  News
//
//  Created by fengdaq on 15/3/14.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureData.h"
#import "ImageDownloader.h"

@interface PictureTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel *titleLable;
@property (nonatomic,retain)UIImageView *firstImage;
@property (nonatomic,retain)UIImageView *secondImage;
@property (nonatomic,retain)UIImageView *thirdImage;
@property (nonatomic,retain)UILabel *dateLabel;
@property (nonatomic,retain)UILabel *picNumLabel;
@property (nonatomic,retain)UILabel *comNumLabel;
@property (nonatomic,retain)PictureData *pic;
@property (nonatomic,assign)NSInteger index;

@end
