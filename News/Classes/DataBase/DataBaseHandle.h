//
//  DataBaseHandle.h
//  News
//
//  Created by fengdaq on 15/3/26.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseHandle : NSObject

+ (DataBaseHandle*)shareInstance;

- (void)openDB;
- (void)closeDB;

//插入
- (BOOL)insertProduct:(NSString *)productName
                ProId:(NSString *)proId
             SeriesId:(NSString *)seriesId;
- (void)deleteProductByName:(NSString *)productName;
- (NSMutableArray *)queryAllProduct;

- (BOOL)isFavoProductByName:(NSString *)productName;
@end
