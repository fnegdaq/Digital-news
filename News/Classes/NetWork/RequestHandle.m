//
//  RequestHandle.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "RequestHandle.h"

@implementation RequestHandle

-(id)initWithUrlString:(NSString *)urlString
              paramUrl:(NSString *)paramUrl
                method:(NSString *)method
              delegate:(id<RequestHandleDelegate>)delegate
{
    if (self = [super init]) {
        _delegate = delegate;
        if ([method isEqualToString:@"GET"]) {
            [self getRequestUrlString:urlString];
        }else if([method isEqualToString:@"POST"]){
            [self postRequestUrlString:urlString ParamUrl:paramUrl];
        }
    }
    return self;
}

- (void)getRequestUrlString:(NSString *)urlString
{
    NSString *path = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __weak typeof(self) weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if ([weakSelf.delegate respondsToSelector:@selector(setRequestHandle:requestSuccessData:)]) {
            [weakSelf.delegate setRequestHandle:self requestSuccessData:data];
        }
    }];
}

- (void)postRequestUrlString:(NSString *)urlString
                    ParamUrl:(NSString *)paramUrl
{
    NSString *path = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSString *paramPath = [NSString stringWithFormat:@"%@",paramUrl];
    NSData *data = [paramPath dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [request setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ([_delegate respondsToSelector:@selector(setRequestHandle:requestSuccessData:)]) {
            [_delegate setRequestHandle:self requestSuccessData:data];
        }
    }];
}

@end
