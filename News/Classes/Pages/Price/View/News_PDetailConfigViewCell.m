//
//  News_PDetailConfigViewCell.m
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_PDetailConfigViewCell.h"
#import "UITableViewCell+TextHeight.h"

@implementation News_PDetailConfigViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCustomCell];
    }
    return self;
}

- (void)createCustomCell
{
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 9, (ViewWidth)/4, 30)];
   // _nameLabel.backgroundColor = [UIColor cyanColor];
    _nameLabel.font = [UIFont systemFontOfSize:15.0];
    _nameLabel.numberOfLines = 0;
   // _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLabel];
    
    self.colonLabel = [[UILabel alloc]initWithFrame:CGRectMake((ViewWidth)/3-10, 3, 20, 30)];
    _colonLabel.text = @":";
    [self.contentView addSubview:_colonLabel];
    
    self.valueLabel = [[UILabel alloc]initWithFrame:CGRectMake((ViewWidth)/3+10, 9, ViewWidth/3.0*2-15, 30)];
  //  _valueLabel.backgroundColor = [UIColor greenColor];
    _valueLabel.font = [UIFont systemFontOfSize:15.0];
    _valueLabel.numberOfLines = 0;
   // _valueLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_valueLabel];
    
}

- (void)setProductDetail:(News_ProductDetailModel *)productDetail
{
    _productDetail = productDetail;
    
    self.nameLabel.text = productDetail.name;
    self.valueLabel.text = productDetail.configValue;
    
    CGFloat height1 = [[self class] getText:_nameLabel.text FontSize:15.0 Width: (ViewWidth)/3-15];
    CGRect rect1 = _nameLabel.frame;
    rect1.size.height = height1;
    _nameLabel.frame = rect1;
    
    CGFloat height = [[self class] getText:_valueLabel.text FontSize:15.0 Width:ViewWidth/3.0*2-20];
    CGRect rect = _valueLabel.frame;
    rect.size.height = height;
    _valueLabel.frame = rect;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
