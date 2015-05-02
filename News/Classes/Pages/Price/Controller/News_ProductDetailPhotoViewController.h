//
//  News_ProductDetailPhotoViewController.h
//  News
//
//  Created by fengdaq on 15/3/18.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface News_ProductDetailPhotoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (copy, nonatomic) NSString *seriesId;
@property (copy, nonatomic) NSString *proId;

@end
