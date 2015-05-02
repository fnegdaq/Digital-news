//
//  BYConditionBar.h
//  BYDailyNews
//
//  Created by bassamyan on 15/1/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News_HomePageViewController;

@interface BYListBar : UIScrollView

@property (nonatomic,copy) void(^arrowChange)();
@property (nonatomic,copy) void(^listBarItemClickBlock)(NSString *itemName , NSInteger itemIndex);
@property (nonatomic, strong) News_HomePageViewController *homeController;
@property (nonatomic,copy) NSString * itemName;
@property (nonatomic,retain)NSMutableArray * newsArray;
@property (nonatomic,assign)NSInteger buttonIndex;
@property (nonatomic,assign)NSInteger listTop;

@property (nonatomic,strong) NSMutableArray *visibleItemList;

-(void)operationFromBlock:(animateType)type itemName:(NSString *)itemName index:(int)index;
-(void)itemClickByScrollerWithIndex:(NSInteger)index;

//- (NSArray *)setArraryWithValue:(NSArray  *)array;

@end
