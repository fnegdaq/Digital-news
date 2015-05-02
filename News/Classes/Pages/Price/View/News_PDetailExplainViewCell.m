//
//  News_PDetailExplainViewCell.m
//  News
//
//  Created by fengdaq on 15/3/16.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_PDetailExplainViewCell.h"
#import "UITableViewCell+TextHeight.h"

@implementation News_PDetailExplainViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCustomCell];
    }
    return self;
}

- (void)createCustomCell
{
    self.brandNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ViewWidth-20, 40)];
  //  _brandNameLabel.backgroundColor = [UIColor cyanColor];
    _brandNameLabel.font = [UIFont boldSystemFontOfSize:20.0];
    
    [self.contentView addSubview:_brandNameLabel];
    
    self.explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, ViewWidth-20, 0)];
    _explainLabel.font = [UIFont systemFontOfSize:15.0];
   // _explainLabel.backgroundColor = [UIColor redColor];
    _explainLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_explainLabel];
    
    self.priceRangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, ViewWidth/2,30)];
    _priceRangeLabel.font = [UIFont boldSystemFontOfSize:18.0];
   // _priceRangeLabel.backgroundColor = [UIColor greenColor];
    _priceRangeLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_priceRangeLabel];
    
    self.saleNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth/2,50, ViewWidth/2-10, 30)];
    _saleNumLabel.font = [UIFont systemFontOfSize:15.0];
    //_saleNumLabel.backgroundColor = [UIColor blueColor];
    _saleNumLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_saleNumLabel];
    
}

- (void)setProductDetail:(News_ProductDetailModel *)productDetail
{
    _productDetail = productDetail;
  
    self.brandNameLabel.text = productDetail.name;
    
    NSString *string1 = productDetail.priceRange;
    self.priceRangeLabel.text = [NSString stringWithFormat: @"¥ %@",string1];
    //self.saleNumLabel.text = [NSString stringWithFormat:@"%ld",(long)productDetail.saleNum];
  
    if ([productDetail.sellNum isEqualToString:@""]) {
        self.saleNumLabel.text = [NSString stringWithFormat:@"月销售量: 暂无"];
    }else{
    self.saleNumLabel.text = [NSString stringWithFormat:@"月销售量:%@",productDetail.sellNum];
    }
    //自适应高度
    self.explainLabel.text = productDetail.brief;
    CGFloat height = [[self class] getText:_explainLabel.text FontSize:15.0 Width:ViewWidth-20];
    CGRect rect = _explainLabel.frame;
    rect.size.height = height;
    _explainLabel.frame = rect;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
