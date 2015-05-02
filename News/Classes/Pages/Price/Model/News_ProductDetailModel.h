//
//  News_ProductDetailModel.h
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News_ProductDetailModel : NSObject

@property (copy, nonatomic) NSString *name;   //paramArr seriesInfo ---name公用
@property (copy, nonatomic) NSString *configValue;
@property (copy, nonatomic) NSString *brief; //产品shuoming
@property (copy, nonatomic) NSString *mainId; //详细配置对应proId
@property (copy, nonatomic) NSString *seriesId; //对应id;
@property (copy, nonatomic) NSString *priceRange; //价格范围
@property (copy, nonatomic) NSString *seriesProNum;//共几款..
@property (copy, nonatomic) NSString *pic;
@property (copy, nonatomic) NSString *sellNum; //月销售

@end
