//
//  News_PDetailPhotoView.h
//  News
//
//  Created by fengdaq on 15/3/18.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoBrowser.h"

@interface News_PDetailPhotoView : UIView<SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *photoItemArray;
@property (nonatomic)CGFloat cellHeight;
@end
