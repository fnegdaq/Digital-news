//
//  News_ProductDetailModel.m
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_ProductDetailModel.h"

@implementation News_ProductDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.seriesId = value;
    }
    if ([key isEqualToString:@"value"]) {
        self.configValue = value;
    }
}

@end
