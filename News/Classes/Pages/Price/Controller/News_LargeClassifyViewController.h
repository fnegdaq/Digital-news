//
//  News_LargeClassifyViewController.h
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^SendSubId)(NSString*);

@protocol LargeClassifyDelegate <NSObject>

- (void)sendSubIdToSmallClassify:(NSString *)subId;

@end

@interface News_LargeClassifyViewController : UITableViewController

@property (assign, nonatomic) id<LargeClassifyDelegate> delegate;

//@property (copy, nonatomic) SendSubId sendSubId;

@end
