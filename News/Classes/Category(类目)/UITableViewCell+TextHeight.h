//
//  UITableViewCell+TextHeight.h
//  News
//
//  Created by fengdaq on 15/3/10.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (TextHeight)

+ (CGFloat)getText:(NSString*)text
          FontSize:(CGFloat)fontSize
             Width:(CGFloat)width;

@end
