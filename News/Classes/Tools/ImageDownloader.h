//
//  ImageDownloader.h
//  ui 17 异步图片下载
//
//  Created by lanou3g on 15-1-5.
//  Copyright (c) 2015年 Thirtyseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//定义一个协议并创建一个方法
@protocol ImageDownloaderDelegate <NSObject>

- (void)imageDownloaderDidFinishLoading:(UIImage *)img;

@end

@interface ImageDownloader : NSObject
//初始化方法
- (id)initWithUrlString:(NSString *)urlStr;
- (id)initWithUrlString:(NSString *)urlStr delegate:(id<ImageDownloaderDelegate>)delegate;//初始化时候直接把代理给他
+ (ImageDownloader *)imageDownloader:(NSString *)urlStr delegate:(id<ImageDownloaderDelegate>)delegate;
//开始下载
- (void)startDownload;
@property(nonatomic,copy)NSString * urlStr;
@property(nonatomic,assign)id<ImageDownloaderDelegate>delegate;

@end
