//
//  News_PDetailExplainViewCell.h
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News_ProductDetailModel.h"

@interface News_PDetailExplainViewCell : UITableViewCell

@property(retain, nonatomic) UILabel *brandNameLabel;
@property(retain, nonatomic) UILabel *explainLabel;
@property(retain, nonatomic) UILabel *priceRangeLabel;
@property(retain, nonatomic) UILabel *saleNumLabel;

@property(retain, nonatomic) News_ProductDetailModel *productDetail;

@end
