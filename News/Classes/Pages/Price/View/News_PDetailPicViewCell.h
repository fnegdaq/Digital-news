//
//  News_PDetailPicViewCell.h
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News_ProductDetailModel.h"

@interface News_PDetailPicViewCell : UITableViewCell

@property (retain,nonatomic) UIImageView *imagePic;
@property (retain,nonatomic) UILabel *didLabel;
@property (retain,nonatomic) UILabel *oneLabel;
@property (retain,nonatomic) News_ProductDetailModel *productPic;

@end
