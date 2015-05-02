//
//  News_SmallClassifyViewCell.m
//  News
//
//  Created by fengdaq on 15/3/11.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#define CONTENTVIEW self.contentView.frame.size

#import "News_SmallClassifyViewCell.h"
#import "UIImageView+WebCache.h"


@implementation News_SmallClassifyViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //[[SDImageCache sharedImageCache] clearDisk];
        [self createCustomCell];
    }
    return self;
}

- (void)createCustomCell
{
    if (BIGTHANI5S) {
        self.brandLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, CONTENTVIEW.width*0.75/3.0,CONTENTVIEW.height-11)];
        self.brandName = [[UILabel alloc]initWithFrame:CGRectMake(CONTENTVIEW.width*0.75/3.0+20, 0, CONTENTVIEW.width*0.75/3.0*2, CONTENTVIEW.height+11)];
    }else{
        self.brandLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, CONTENTVIEW.width*0.65/3.0,CONTENTVIEW.height-11)];
        self.brandName = [[UILabel alloc]initWithFrame:CGRectMake(CONTENTVIEW.width*0.65/3.0+20, 0, CONTENTVIEW.width*0.65/3.0*2, CONTENTVIEW.height+11)];
    }
    
    _brandLogo.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_brandLogo];
    
    
   // _brandName.textAlignment = NSTextAlignmentCenter;
   // _brandName.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_brandName];
    
}

- (void)setSamllClassify:(News_SmallClassifyModel *)samllClassify{
 
    NSURL *url = [NSURL URLWithString:samllClassify.pic];
    [_brandLogo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"picholder"]];
    self.brandName.text = samllClassify.name;
    self.brandId = samllClassify.ID;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
