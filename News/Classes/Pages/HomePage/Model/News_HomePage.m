//
//  News_HomePage.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_HomePage.h"

@implementation News_HomePage
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%d,%d,%d,%d,%d,%d",_title,_pubDate,_image,_url,_bigImage,_focus,_topArticle,_cmtCount,_informationType,_pageNo,_pageSize,_seq,_updateAt];
}
@end
