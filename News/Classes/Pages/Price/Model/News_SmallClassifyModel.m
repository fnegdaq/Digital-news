//
//  News_SmallClassifyModel.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_SmallClassifyModel.h"

@implementation News_SmallClassifyModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([ key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
