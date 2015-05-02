//
//  News_PDetailPicViewCell.m
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_PDetailPicViewCell.h"
#import "UIImageView+WebCache.h"

@implementation News_PDetailPicViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imagePic = [[UIImageView alloc]initWithFrame:CGRectMake(30, 10, ViewWidth-60 , ViewHeight/3+10)];
       // _imagePic.backgroundColor = [UIColor cyanColor];
        
        [self.contentView addSubview:_imagePic];
        
        self.didLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 60, 30)];
        _didLabel.text = @"图集";
        _didLabel.font = [UIFont systemFontOfSize:14.0];
        _didLabel.textColor = [UIColor lightGrayColor];
        [self.imagePic addSubview:_didLabel];
        
        self.oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, ViewHeight/3+20, ViewWidth-20, 30)];
        _oneLabel.text = @"查看更多图片  >";
        _oneLabel.font = [UIFont systemFontOfSize:14.0];
        _oneLabel.textAlignment = NSTextAlignmentCenter;
        _oneLabel.textColor = [UIColor colorWithRed:0/255 green:132.0/255 blue:255.0/255 alpha:0.9];
        [self.contentView addSubview:_oneLabel];
        
        UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth/3.0*2+5, ViewHeight/3.0-30, ViewWidth/3, 40)];
        secondLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:secondLabel];
        
    }
    return self;
}

- (void)setProductPic:(News_ProductDetailModel *)productPic
{
    _productPic = productPic;
    
    NSURL *url = [NSURL URLWithString:productPic.pic];
    
    [self.imagePic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"picholder"]];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
