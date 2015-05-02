//
//  DataBaseHandle.m
//  News
//
//  Created by fengdaq on 15/3/26.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "DataBaseHandle.h"
#import <sqlite3.h>

@implementation DataBaseHandle

static DataBaseHandle * dataBaseHandle = nil;
+ (DataBaseHandle*)shareInstance
{
    @synchronized(self)
    {
        if (nil == dataBaseHandle)
        {
            dataBaseHandle = [[DataBaseHandle alloc]init];
        }
    }
    return dataBaseHandle;
}

static sqlite3 *db = nil;

- (void)openDB
{
    if (db != nil)
    {
        NSLog(@"数据库存在并打开鸟~");
        return;
    }
    //1.
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [path stringByAppendingPathComponent:@"data.sqlite"];
    //2.根据路径创建并打开数据库
    int result = sqlite3_open(dbPath.UTF8String, &db);
    if (result == SQLITE_OK)
    {
        NSString *sql = @"create table Product (name Text Primary Key,proId Text,seriesId Text)";
        //执行sql语句
        int result1 = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
        if (result1 == SQLITE_OK)
        {
            NSLog(@"success");
        }else
        {
            NSLog(@"existing");
        }
    }
}

- (void)closeDB
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"close success");
        db = nil;
    }else{
        NSLog(@"close fail");
    }
}

//插入
- (BOOL)insertProduct:(NSString *)productName
                ProId:(NSString *)proId
             SeriesId:(NSString *)seriesId
{
    BOOL isSuccess = NO;
    [self openDB];
    
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare_v2(db, [@"insert into Product(name,proId,seriesId) values(?,?,?)" UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, productName.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 2, proId.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 3, seriesId.UTF8String, -1, NULL);
        if (sqlite3_step(stmt) == SQLITE_DONE)
        {
            isSuccess = YES;
            NSLog(@"insert success");
        }
    }
    sqlite3_finalize(stmt);
    [self closeDB];
    return isSuccess;
}

- (void)deleteProductByName:(NSString *)productName
{
    [self openDB];
    NSString *deleteSql = [NSString stringWithFormat:@"delete from Product where name = '%@'",productName];
    sqlite3_exec(db, deleteSql.UTF8String, NULL, NULL, NULL);
    [self closeDB];
}

- (NSMutableArray *)queryAllProduct
{
    [self openDB];
    //创建跟随指针
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare_v2(db, [@"select * from Product" UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        NSMutableArray *array = [NSMutableArray array];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 0)] forKey:@"ProductName"];
            [dic setValue:[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)] forKey:@"ProId"];
            [dic setValue:[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)] forKey:@"SeriesId"];
            [array addObject:dic];
        }
        sqlite3_finalize(stmt);
        [self openDB];
        return array;
    }
    
    [self openDB];
    return nil;
}

- (BOOL)isFavoProductByName:(NSString *)productName
{
    NSMutableArray *array = [self queryAllProduct];
    
    for (NSDictionary *dic in array)
    {
        if ([productName isEqualToString:[dic objectForKey:@"ProductName"]]) {
            return YES;
        }
    }
    return NO;
}
@end
