//
//  News_ProductListViewCell.m
//  News
//
//  Created by fengdaq on 15/3/12.
//  Copyright (c) 2015年 lxf. All rights reserved.
//
#define CONTENTVIEW self.contentView.frame.size

#import "News_ProductListViewCell.h"
#import "UIImageView+WebCache.h"

@implementation News_ProductListViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCustomCell];
    }
    return self;
}

- (void)createCustomCell
{
    self.producePic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, CONTENTVIEW.width/4.0, CONTENTVIEW.height+31)];
    
    if (BIGTHANI5S) {
        self.produceName = [[UILabel alloc]initWithFrame:CGRectMake(20+CONTENTVIEW.width/4.0, 10, CONTENTVIEW.width/5.0*4, CONTENTVIEW.height-10)];
        self.produceHit = [[UILabel alloc]initWithFrame:CGRectMake(20+CONTENTVIEW.width/4.0, 10+CONTENTVIEW.height, CONTENTVIEW.width/4.0*2, CONTENTVIEW.height/2+9)];
        self.producePrice = [[UILabel alloc]initWithFrame:CGRectMake(30+CONTENTVIEW.width/4.0*3, CONTENTVIEW.height, CONTENTVIEW.width/4.0+10, CONTENTVIEW.height/2+20)];
    }else{
        
        self.produceName = [[UILabel alloc]initWithFrame:CGRectMake(20+CONTENTVIEW.width/4.0, 10, CONTENTVIEW.width/3*2.0, CONTENTVIEW.height-10)];
        self.produceHit = [[UILabel alloc]initWithFrame:CGRectMake(20+CONTENTVIEW.width/4.0, 10+CONTENTVIEW.height, CONTENTVIEW.width/5.0*2, CONTENTVIEW.height/2+9)];
        self.producePrice = [[UILabel alloc]initWithFrame:CGRectMake(CONTENTVIEW.width/4.0*3-25, CONTENTVIEW.height, CONTENTVIEW.width/4.0+15, CONTENTVIEW.height/2+20)];
    }
    
//    _producePic.backgroundColor = [UIColor cyanColor];
//    _produceName.backgroundColor = [UIColor greenColor];
//    _produceHit.backgroundColor = [UIColor yellowColor];
//    _producePrice.backgroundColor = [UIColor cyanColor];
    
    _produceName.font = [UIFont systemFontOfSize:16];
    _produceHit.font = [UIFont systemFontOfSize:13];
    _producePrice.font = [UIFont systemFontOfSize:18];
    
    
    _producePrice.textColor = [UIColor redColor];
    _produceHit.textColor = [UIColor darkGrayColor];
    _producePrice.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_producePic];
    [self.contentView addSubview:_produceName];
    [self.contentView addSubview:_produceHit];
    [self.contentView addSubview:_producePrice];
}

- (void)setProduceModel:(News_ProduceListModel *)produceModel
{
    _produceModel = produceModel;
    
    self.produceName.text = produceModel.name;
    self.produceHit.text =[@"周关注量:"  stringByAppendingString:produceModel.thisWeekHit];
    self.producePrice.text = [@"¥ " stringByAppendingString: produceModel.price];
    
    NSURL *url = [NSURL URLWithString:produceModel.pic];
   
    [self.producePic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"picholder"]];
    
    self.seriesId = produceModel.seriesId;
    self.productId = produceModel.proId;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
