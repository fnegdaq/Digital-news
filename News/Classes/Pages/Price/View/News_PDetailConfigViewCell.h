//
//  News_PDetailConfigViewCell.h
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News_ProductDetailModel.h"

@interface News_PDetailConfigViewCell : UITableViewCell

@property (retain, nonatomic) UILabel *nameLabel;
@property (retain, nonatomic) UILabel *valueLabel;
@property (retain, nonatomic) UILabel *colonLabel;

@property (retain, nonatomic)News_ProductDetailModel *productDetail;


@end
