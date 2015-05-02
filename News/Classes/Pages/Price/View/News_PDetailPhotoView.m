//
//  News_PDetailPhotoView.m
//  News
//
//  Created by fengdaq on 15/3/18.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#define SDPhotoGroupImageMargin 15

#import "News_PDetailPhotoView.h"
#import "UIButton+WebCache.h"
#import "News_ProductPhotoModel.h"

@implementation News_PDetailPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    _photoItemArray = photoItemArray;
    [photoItemArray enumerateObjectsUsingBlock:^(News_ProductPhotoModel *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [[UIButton alloc] init];
        [btn sd_setImageWithURL:[NSURL URLWithString:obj.picSrc] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"picholder"]];
        
        btn.tag = idx;
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }];
}

-(CGFloat)cellHeight{
    int imageCount = (int)self.photoItemArray.count;
    int perRowImageCount = ((imageCount == 4) ? 2 : 3);
    
    int totalRowCount = imageCount / perRowImageCount + 0.99999; // ((imageCount + perRowImageCount - 1) / perRowImageCount)
    _cellHeight = (totalRowCount+1) * (SDPhotoGroupImageMargin + 110);
    return _cellHeight;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    int imageCount = (int)self.photoItemArray.count;

    int perRowImageCount = ((imageCount == 4) ? 2 : 3);
    
    int totalRowCount = imageCount / perRowImageCount + 0.99999; // ((imageCount + perRowImageCount - 1) / perRowImageCount)
    CGFloat w =([UIScreen mainScreen].bounds.size.width - 50)/3;
    CGFloat h = 110;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        
        int rowIndex = (int)idx / perRowImageCount;
        int columnIndex = idx % perRowImageCount;
        CGFloat x = columnIndex * (w + SDPhotoGroupImageMargin);
        CGFloat y = rowIndex * (h + SDPhotoGroupImageMargin);
        btn.frame = CGRectMake(x, y, w, h);
    }];
    
    self.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width, (totalRowCount+1) * (SDPhotoGroupImageMargin + 110));
//    NSLog(@"--------------------%d",(totalRowCount+1) * (SDPhotoGroupImageMargin + 110));
//    NSLog(@"===================%d",totalRowCount);
}

- (void)buttonClick:(UIButton *)button
{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.photoItemArray.count; // 图片总数
    browser.currentImageIndex =(int) button.tag;
    browser.delegate = self;
    [browser show];
    
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.subviews[index] currentImage];
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
//    if (ViewHeight == 480) {
//        NSString *urlStr = [[self.photoItemArray[index] picSrc] stringByReplacingOccurrencesOfString:@"180x540" withString:@"320*480"];
//        return [NSURL URLWithString:urlStr];
//    }else{
    NSString *urlStr = [[self.photoItemArray[index] picSrc] stringByReplacingOccurrencesOfString:@"180x540" withString:@"640x480"];
    return [NSURL URLWithString:urlStr];
//    }
}

@end
