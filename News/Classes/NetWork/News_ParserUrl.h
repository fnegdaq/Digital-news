//
//  News_ParserUrl.h
//  News
//
//  Created by lanou3g on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News_ParserUrl : NSObject
- (instancetype)parserUrlFromPacific:(NSString *)url;
- (instancetype)parserUrlFromZOL:(NSString *)url;
@end
