//
//  News_ProductListViewCell.h
//  News
//
//  Created by fengdaq on 15/3/12.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News_ProduceListModel.h"

@interface News_ProductListViewCell : UITableViewCell

@property (retain, nonatomic) UIImageView *producePic;
@property (retain, nonatomic) UILabel *produceName;
@property (retain, nonatomic) UILabel *produceHit;
@property (retain, nonatomic) UILabel *producePrice;
@property (copy,   nonatomic) NSString *seriesId;
@property (copy,   nonatomic) NSString *productId;

@property (retain, nonatomic) News_ProduceListModel *produceModel;

@end
