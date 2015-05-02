//
//  PictureTableViewCell.m
//  News
//
//  Created by fengdaq on 15/3/14.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "PictureTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "News_DetailViewController.h"
#define CellHeight self.contentView.bounds.size.height
@implementation PictureTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self createSubviews];
      
    }
    return self;
}
- (void)createSubviews
{
    
    
   
    
    
    self.titleLable=[[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.04, 0, ViewWidth*0.9, CellHeight*1)];
    _titleLable.text=@"今年买个表 Apple  Watch最高售888888美元";
    [self.contentView addSubview:_titleLable];
    self.firstImage=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth*0.04, CellHeight*0.95, ViewWidth*0.293333, CellHeight*1.7)];
    _titleLable.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_firstImage];
    
    self.secondImage=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth*0.3533, CellHeight*0.95, ViewWidth*0.293333, CellHeight*1.7)];
    _secondImage.backgroundColor=[UIColor grayColor];
    [self.contentView addSubview:_secondImage];
    
    self.thirdImage=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth*0.666666, CellHeight*0.95, ViewWidth*0.293333, CellHeight*1.7)];
    _thirdImage.backgroundColor=[UIColor greenColor];
    [self.contentView addSubview:_thirdImage];
    
    self.dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.04, CellHeight*2.8, ViewWidth*0.4, 20 )];
    _dateLabel.text=@"2015-03-10";
    _dateLabel.font=[UIFont systemFontOfSize:12.0];
    _dateLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_dateLabel];
    
    self.picNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.7, CellHeight*2.8, ViewWidth*0.4, 20 )];
    _picNumLabel.text=@"13";
    _picNumLabel.font=[UIFont systemFontOfSize:12.0];
    _picNumLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_picNumLabel];
    
    
   self.comNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.85, CellHeight*2.8, ViewWidth*0.4, 20 )];
    _comNumLabel.text=@"6";
    
    _comNumLabel.font=[UIFont systemFontOfSize:12.0];
    _comNumLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_comNumLabel];
    
    UIView * grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, ViewWidth, 8)];
    grayView.backgroundColor = [UIColor colorWithWhite:0.91 alpha:1.0];
    [self.contentView addSubview:grayView];

}

- (void)setPic:(PictureData *)pic
{
    self.titleLable.text=pic.title;
    self.dateLabel.text=pic.date;
    self.comNumLabel.text=[NSString stringWithFormat:@"%d评论",pic.comNum];
    self.picNumLabel.text=[NSString stringWithFormat:@"%d图",pic.num];
    
    if ([pic.imgSrc isKindOfClass:[NSMutableArray class]]) {
        [_firstImage sd_setImageWithURL:[NSURL URLWithString:pic.imgSrc[0]] placeholderImage:[UIImage imageNamed:@"picholder"]];
        [_secondImage sd_setImageWithURL:[NSURL URLWithString:pic.imgSrc[1]] placeholderImage:[UIImage imageNamed:@"picholder"]];
        [_thirdImage sd_setImageWithURL:[NSURL URLWithString:pic.imgSrc[2]] placeholderImage:[UIImage imageNamed:@"picholder"]];
    }
}
- (void)awakeFromNib {
    // Initialization code
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
