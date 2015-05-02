//
//  News_LargeClassifyViewCell.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//



#import "News_LargeClassifyViewCell.h"

@implementation News_LargeClassifyViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createCustomCell];
    }
    return self;
}

- (void)createCustomCell
{

    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ViewWidth*0.35,self.contentView.frame.size.height)];

    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    
    [self.contentView addSubview:_titleLabel];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    /**
     *  每个cell只能点一次,要不然oneImageView设定的动画就移除不了~乱jb
     */
    if (self.selected == selected) {
        return;
    }
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if (selected) {
        UIImageView *oneImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navback.png"]];
        oneImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        oneImageView.tag = 1001;
        [self.contentView addSubview:oneImageView];
        [UIView animateWithDuration:0.2 animations:^{
            oneImageView.frame = CGRectMake(-self.bounds.size.width+5, 0, oneImageView.frame.size.width, oneImageView.frame.size.height);
        }];
        _titleLabel.textColor = [UIColor colorWithRed:0/255 green:132.0/255 blue:255.0/255 alpha:0.9];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setLargeCM:(News_LargeClassifyModel *)largeCM
{
    _titleLabel.text = largeCM.name;
    _subIdString = largeCM.subId;
}
@end
