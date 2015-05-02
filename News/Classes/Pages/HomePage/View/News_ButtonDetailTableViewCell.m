//
//  News_ButtonDetailTableViewCell.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.

#import "News_ButtonDetailTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation News_ButtonDetailTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCustomCell];
    }
    return self;
}
- (void)createCustomCell
{
    self.newsImageView = [[UIImageView alloc]init];
    _newsImageView.frame = CGRectMake(5, 5, ViewWidth*0.3, self.contentView.bounds.size.height*1.6);
    [self.contentView addSubview:_newsImageView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.35, -10, ViewWidth*0.6, self.contentView.bounds.size.height*1.5)];
    _timeLabel.backgroundColor = [UIColor redColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.35, self.contentView.bounds.size.height*1.3, ViewWidth*0.3, self.contentView.bounds.size.height*0.5)];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    
    self.commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.8, self.contentView.bounds.size.height*1.3,ViewWidth*0.3, self.contentView.bounds.size.height*0.5)];
    _commentLabel.font = [UIFont systemFontOfSize:10];
    _commentLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_commentLabel];
}
- (void)setNewsHomePage:(News_HomePage *)newsHomePage
{
    _titleLabel.text = newsHomePage.title;
    NSURL * url = [NSURL URLWithString:newsHomePage.image];
    if (url) {
        SDImageCache *imageCache = [SDImageCache sharedImageCache];
        UIImage *image = [imageCache imageFromDiskCacheForKey:newsHomePage.image];
        if (image) {
            self.newsImageView.image = image;
        }else{
            [_newsImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"picholder"]];
        }
    }
    
    if (newsHomePage.cmtCount == 0) {
        _commentLabel.text = @"抢沙发";
    }else{
        _commentLabel.text = [NSString stringWithFormat:@"%d评论",newsHomePage.cmtCount];
    }
    _timeLabel.text = newsHomePage.pubDate;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
