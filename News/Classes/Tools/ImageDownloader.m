//
//  ImageDownloader.m
//  ui 17 异步图片下载
//
//  Created by lanou3g on 15-1-5.
//  Copyright (c) 2015年 Thirtyseven. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader
//初始化方法
- (id)initWithUrlString:(NSString *)urlStr
{
    self = [super init];
    if (self) {
        _urlStr = [urlStr copy];
    }
    return self;
}
//开始下载
- (void)startDownload
{
    //1、准备URL
    NSString * urlStr = _urlStr;
    //2、创建url
    NSURL * url = [NSURL URLWithString:urlStr];
    //3、创建请求对象
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    //4、设置请求方法
    [request setHTTPMethod:@"GET"];
    //    //5、创建response对象
    //    NSURLResponse * resp = nil;
    //    NSError * error = nil;
    //6、创建连接对象，发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        UIImage * img = [[UIImage alloc]initWithData:data];
        //如果代理不为空并且响应这个方法，代理才去才执行这个方法
        if (_delegate != nil && [_delegate respondsToSelector:@selector(imageDownloaderDidFinishLoading:)]) {
                       [_delegate imageDownloaderDidFinishLoading:img];
        }
    }];

}

- (id)initWithUrlString:(NSString *)urlStr delegate:(id<ImageDownloaderDelegate>)delegate
{
    self = [self initWithUrlString:urlStr];//指定初始化方法
    if (self) {
        _delegate = delegate;
    }
    return self;
}
+ (ImageDownloader *)imageDownloader:(NSString *)urlStr delegate:(id<ImageDownloaderDelegate>)delegate
{
    ImageDownloader * downloader = [[ImageDownloader alloc]initWithUrlString:urlStr delegate:delegate];
    [downloader startDownload];
    return downloader;
}
@end
