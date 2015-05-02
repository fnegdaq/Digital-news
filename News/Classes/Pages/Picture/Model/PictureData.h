//
//  PictureData.h
//  News
//
//  Created by fengdaq on 15/3/14.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloader.h"
#import <UIKit/UIKit.h>

@interface PictureData : NSObject

@property (nonatomic,copy)NSString *date;
@property (nonatomic,retain)NSMutableArray *imgSrc;
@property (nonatomic,assign)int comNum;
@property (nonatomic,assign)int num;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *isProPic;
@property (nonatomic,retain)UIImage * img0;
@property (nonatomic,retain)UIImage * img1;
@property (nonatomic,retain)UIImage * img2;
@property (nonatomic,copy)NSString * url;
@property (nonatomic,copy)NSString * comId;
//@property (nonatomic,assign)BOOL isDownloading;

@end
