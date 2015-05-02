//
//  RequestHandle.h
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RequestHandle;
@protocol RequestHandleDelegate <NSObject>

- (void)setRequestHandle:(RequestHandle *)requestHandle
      requestSuccessData:(NSData *)successData;

@end

@interface RequestHandle : NSObject

@property (assign ,nonatomic) id<RequestHandleDelegate>delegate;

-(id)initWithUrlString:(NSString *)urlString
              paramUrl:(NSString *)paramUrl
                method:(NSString *)method
              delegate:(id<RequestHandleDelegate>)delegate;

@end
