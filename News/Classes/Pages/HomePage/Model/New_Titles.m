//
//  New_Titles.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.

#import "New_Titles.h"

#define kNewsTitleName @"kNewsTitleName"
#define kNewsTitleUrl @"kNewsTitleUrl"

#define kNewsTopTitlePlist @"kNewsTopTitlePlist.plist"
#define kNewsBottomTitlePlist @"kNewsBottomTitlePlist.plist"

@implementation New_Titles

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemName forKey:kNewsTitleName];
//    [aCoder encodeObject:self.urlString forKey:kNewsTitleUrl];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.itemName = [aDecoder decodeObjectForKey:kNewsTitleName];
//    self.urlString = [aDecoder decodeObjectForKey:kNewsTitleUrl];
    return self;
}

@end


@implementation New_TitlesManager

+ (NSArray *)loadTopTitle
{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),kNewsTopTitlePlist];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return array;
}

+ (void)saveTopTitleWithArray:(NSArray *)array1
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),kNewsTopTitlePlist];

    NSMutableArray *array = [NSMutableArray array];
    if (![fileManager isExecutableFileAtPath:path])
    {
        
        for (NSString *titleName in array1) {
            New_Titles *title = [[New_Titles alloc] init];
            title.itemName = titleName;
            [array addObject:title];
            BOOL success = [NSKeyedArchiver archiveRootObject:array toFile:path];
            if (success)
            {
//                NSLog(@"success");
            }
            else
            {
//                NSLog(@"faild");
            }
        }
        
    }
}

+ (NSArray *)loadBottomTitle
{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),kNewsBottomTitlePlist];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return array;
}

+ (void)saveBottomTitleWithArray:(NSArray *)array1{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),kNewsBottomTitlePlist];

    NSMutableArray *array = [NSMutableArray array];
    if (![fileManager isExecutableFileAtPath:path])
    {
        
        for (NSString *titleName in array1) {
            New_Titles *title = [[New_Titles alloc] init];
            title.itemName = titleName;
            [array addObject:title];
            BOOL success = [NSKeyedArchiver archiveRootObject:array toFile:path];
            if (success)
            {
//                NSLog(@"success");
            }
            else
            {
//                NSLog(@"faild");
            }
        }
        
    }
    
}

@end