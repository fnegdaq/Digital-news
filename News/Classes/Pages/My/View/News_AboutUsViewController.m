//
//  News_AboutUsViewController.m
//  News
//
//  Created by fengdaq on 15/3/24.
//  Copyright (c) 2015年 lxf. All rights reserved.

#import "News_AboutUsViewController.h"

@interface News_AboutUsViewController ()

@end

@implementation News_AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.titleTextAttributes
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_001"] style:UIBarButtonItemStyleDone target:self action:@selector(left)];
    self.navigationItem.leftBarButtonItem = left;
    
    
    UIImageView * iconView = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth*0.35,ViewHeight*0.05, ViewWidth*0.3, ViewWidth*0.3)];
    iconView.image = [UIImage imageNamed:@"Icon-76@2x"];
    [self.view addSubview:iconView];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.39, ViewHeight*0.27, ViewWidth*0.23, ViewHeight*0.04)];
    //    nameLabel.backgroundColor = [UIColor redColor];
    nameLabel.text = @"科技前沿";
    nameLabel.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:nameLabel];
    
    UILabel * numLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.45, ViewHeight*0.3, ViewWidth*0.2, ViewHeight*0.05)];
    numLabel.text = @"v1.0";
    //    numLabel.backgroundColor = [UIColor blueColor];
    numLabel.font = [UIFont systemFontOfSize:12];
    numLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:numLabel];
    
    UILabel * introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.1, ViewHeight*0.35, ViewWidth*0.8, ViewHeight*0.3)];
    introduceLabel.numberOfLines = 0;
    introduceLabel.text = [NSString stringWithFormat:@"作为致力于科技光速发展的当代有为青年,我感到肩上的压力非常大,但是就是与生俱来的拼搏气质让我一次次的前进,我相信未来的祖国会在我们这群正直、勤劳、勇敢、机智、谦虚的年轻人努力下,更加辉煌!!!\n科技前沿,历时俩礼拜,凝结了无数人的心血,精心为您打造最新鲜,最时尚,最高端,最刺激的科技资讯,下面是开发者邮箱,欢迎来信"];
    //    introduceLabel.backgroundColor = [UIColor greenColor];
    introduceLabel.font = [UIFont systemFontOfSize:13];
    introduceLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:introduceLabel];
    
    UILabel * emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.1, ViewHeight*0.7, ViewWidth*0.6, ViewHeight*0.1)];
    //    emailLabel.backgroundColor = [UIColor orangeColor];
    emailLabel.numberOfLines = 3;
    emailLabel.text = [NSString stringWithFormat:@"coder:fenngdq@gmail.com"];
    emailLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:emailLabel];
    
    
}
- (void)left
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
