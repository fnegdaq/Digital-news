//
//  News_SmallClassifyViewController.h
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestHandle.h"
#import "News_LargeClassifyViewController.h"

//@protocol SmallClassiyDelegate <NSObject>
//
//- (void)sendToSubId:(NSString *)subId
//            BrandId:(NSString *)brandId;

//@end

@interface News_SmallClassifyViewController : UITableViewController<RequestHandleDelegate,LargeClassifyDelegate>

@property (copy ,nonatomic) NSString *subId;
@property (retain, nonatomic) NSMutableDictionary *afreshGroupDic;  //将index取出 和manuArr取出的数组从新组合
@property (retain, nonatomic) NSMutableArray *sortGroupKey;

@property (copy, nonatomic) NSString *brandId;
//@property (assign, nonatomic) id<SmallClassiyDelegate> delegate;

@end
