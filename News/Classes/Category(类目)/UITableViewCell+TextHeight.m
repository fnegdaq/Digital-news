//
//  UITableViewCell+TextHeight.m
//  News
//  Created by fengdaq on 15/3/10.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "UITableViewCell+TextHeight.h"

@implementation UITableViewCell (TextHeight)
+ (CGFloat)getText:(NSString*)text
          FontSize:(CGFloat)fontSize
             Width:(CGFloat)width
{
    CGSize size = CGSizeMake(width, 77777);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}
@end
