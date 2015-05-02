//
//  New_Titles.h
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface New_Titles : NSObject <NSCoding>

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *urlString;

@end

@interface New_TitlesManager : NSObject

+ (NSArray *)loadTopTitle;

+ (void)saveTopTitleWithArray:(NSArray *)array1;

+ (NSArray *)loadBottomTitle;

+ (void)saveBottomTitleWithArray:(NSArray *)array1;

@end