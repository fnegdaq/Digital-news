//
//  News_ProduceListModel.m
//  News
//
//  Created by fengdaq on 15/3/12.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_ProduceListModel.h"

@implementation News_ProduceListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.proId = value;
    }
}

@end
