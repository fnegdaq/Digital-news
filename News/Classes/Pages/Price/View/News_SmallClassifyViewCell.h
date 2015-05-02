//
//  News_SmallClassifyViewCell.h
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News_SmallClassifyModel.h"
@interface News_SmallClassifyViewCell : UITableViewCell

@property (retain, nonatomic) UIImageView *brandLogo;
@property (retain, nonatomic) UILabel *brandName;
@property (copy, nonatomic) NSString *brandId;


@property (retain, nonatomic) News_SmallClassifyModel *samllClassify;

@end
