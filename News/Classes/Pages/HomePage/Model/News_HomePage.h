//
//  News_HomePage.h
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News_HomePage : NSObject
@property (nonatomic,assign)int cmtCount;//评论数
//@property (nonatomic,copy)NSString * newsId;//新闻id
@property (nonatomic,copy)NSString * image;//新闻图片url;
@property (nonatomic,assign)int informationType;//信息类型 1是啥都没有 2是论坛 3是图集 4是直播 5是专题 6是聚超值
@property (nonatomic,copy)NSString * pubDate;//新闻上传日期
@property (nonatomic,copy)NSString * title;//新闻标题
@property (nonatomic,copy)NSString * url;//非轮播图新闻详情url
@property (nonatomic,copy)NSString * bigImage;//大图,不知道在哪
@property (nonatomic,retain)NSMutableArray * focus;//轮播图数据数组
@property (nonatomic,assign)int pageNo;
@property (nonatomic,assign)int pageSize;
@property (nonatomic,retain)NSMutableArray * topArticle;//置顶新闻数组
@property (nonatomic,assign)int seq;//数据库标号
//@property (nonatomic,copy)NSString * toUri;
@property (nonatomic,assign)int updateAt;
@end
