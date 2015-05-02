//
//  News_DetailViewController.m
//  News
//
//  Created by fengdaq on 15/3/14.
//  Copyright (c) 2015年 lxf. All rights reserved.
//

#import "News_DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "News_CommentsViewController.h"
#import "DetailPicture.h"
#import "ImageDownloader.h"

#define WDetailView self.view.bounds.size.width
#define HDetailView self.view.bounds.size.height
@interface News_DetailViewController ()
@property (nonatomic,retain)NSMutableArray *detailArray;
@property (nonatomic,retain)NSDictionary *dic;
@property (nonatomic,retain)DetailPicture *detamodel;
@property (nonatomic,retain)NSMutableArray * imagesArray;
@property (nonatomic,assign)CGFloat beginPage;
@property (nonatomic,assign)CGFloat endPage;
@end

@implementation News_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor=[UIColor blackColor];
    
//    [self analysis];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
   
    NSString *str=[NSString stringWithFormat:@"http://lib.wap.zol.com.cn/pic_tours/pic_list_ios.php?pro_id=%@&size=640x960",_urlid];
   
    NSURL *url=[NSURL URLWithString:str];
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.dic=dic;
   // NSString * content =[dic objectForKey:@"content"];
    self.detailArray=[NSMutableArray array];
    NSArray *array=[dic objectForKey:@"list"];
//    self.num =(int)[dic objectForKey:@"num"];
    for (NSDictionary *dict in array) {
        DetailPicture * detamodel =[DetailPicture new];
        self. detamodel=detamodel;
        [detamodel setValuesForKeysWithDictionary:dict];
        [_detailArray addObject:detamodel];
        
  
    }

    self.containScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, ViewHeight*0.25, ViewWidth, ViewHeight*0.4)];
    _containScrollView.contentSize=CGSizeMake(ViewWidth *_num, ViewHeight*0.4);
    _containScrollView.delegate=self;
    _containScrollView.pagingEnabled = YES;
    _containScrollView.backgroundColor=[UIColor blackColor];
    _containScrollView.tag = 1;
    self.containScrollView=_containScrollView;
    [self.view addSubview:_containScrollView];
        
    self.imagesArray = [NSMutableArray array];
    for(int i=0;i<_detailArray.count;i++)
        {
            UIScrollView *smallScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(ViewWidth*i, 0, ViewWidth, ViewHeight*0.4)];
            
            smallScrollView.tag = i;
            self.beginPage = i;
            smallScrollView.delegate=self;
            self.  smallScrollView=smallScrollView;
            smallScrollView.maximumZoomScale=2;
            smallScrollView.minimumZoomScale=0.5;
            _containScrollView.pagingEnabled=YES;
            smallScrollView.contentSize=CGSizeMake(ViewWidth, ViewHeight*0.4);
            [_containScrollView addSubview:smallScrollView];
            
            DetailPicture *detam =_detailArray[i];
            NSString *str =detam.images_src;

            UIImageView *imageview =[[UIImageView alloc] initWithFrame:smallScrollView.bounds];
            self.imageview=imageview;
            [imageview sd_setImageWithURL:[NSURL URLWithString:str]];
            [_imagesArray addObject:_imageview];
            [smallScrollView addSubview:imageview];
    
        }
    
    [self createSubviews];
    
}
- (void)createSubviews
{
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.04, HDetailView*0.7, ViewWidth*0.8, 20)];
    titleLabel.text=_newsTitle;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    self.pageLabel =[[UILabel alloc]initWithFrame:CGRectMake(ViewWidth*0.85, HDetailView*0.7, ViewWidth*0.3, 20)];
    _pageLabel.textColor=[UIColor whiteColor];
    _pageLabel.backgroundColor = [UIColor blackColor];
    self.pageLabel.text=[NSString stringWithFormat:@"%.f/%d",_containScrollView.contentOffset.x/ViewWidth+1,_num];
    [self.view addSubview:_pageLabel];
    
    UITextView *contentsTextView=[[UITextView alloc]initWithFrame:CGRectMake(ViewWidth*0.04, HDetailView*0.735, ViewWidth*0.92, HDetailView*0.2)];
    contentsTextView.font=[UIFont systemFontOfSize:14.0];
    contentsTextView.backgroundColor=[UIColor blackColor];
    contentsTextView.textColor=[UIColor whiteColor];
    NSString * content =[_dic objectForKey:@"content"];
    if ([content isEqualToString:@"精彩内容源自网络。"]) {
        contentsTextView.text = @"本组无描述文字，请您欣赏图片";
    }else if ([content isEqualToString:@"精彩内容源自网络"]){
        contentsTextView.text = @"本组无描述文字，请您欣赏图片";
    }else if ([content isEqualToString:@"精彩内容来自网络。"]){
        contentsTextView.text = @"本组无描述文字，请您欣赏图片";
    }
    else{
    contentsTextView.text=content;
    }
    //设置为不可编辑状态
    contentsTextView.editable=NO;
    [self.view addSubview:contentsTextView];
    
    
    UIButton *goBackBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    goBackBtn.frame=CGRectMake(ViewWidth*0.04, ViewWidth*0.04, 30, 30);
    [goBackBtn setImage:[UIImage imageNamed:@"icon_001"] forState:UIControlStateNormal];
    [goBackBtn addTarget:self action:@selector(goBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    goBackBtn.tintColor = [UIColor whiteColor];
    [self.view addSubview:goBackBtn];
    
    
    UIButton *commentsBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    commentsBtn.frame=CGRectMake(ViewWidth*0.75, ViewWidth*0.04, ViewWidth*0.21, 30);
    NSString * str = [NSString stringWithFormat:@"%d评论",self.comCount];
    commentsBtn.tintColor = [UIColor whiteColor];
    [commentsBtn setTitle:str forState:UIControlStateNormal];
    [commentsBtn addTarget:self action:@selector(commentsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentsBtn];

    UIButton *downloadBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    downloadBtn.frame=CGRectMake(ViewWidth*0.85, ViewHeight*0.943, 22, 22);
    [downloadBtn setImage:[UIImage imageNamed:@"download.jpg"] forState:UIControlStateNormal];
    [downloadBtn addTarget:self action:@selector(downloadBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    downloadBtn.tintColor = [UIColor whiteColor];
    [self.view addSubview:downloadBtn];

}
- (void)goBackBtnClicked:(UIButton *)btn
{
    [self  dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)commentsBtnClicked:(UIButton *)btn
{
    News_CommentsViewController *commentsVC=[[News_CommentsViewController alloc]init];
    UINavigationController * comNav = [[UINavigationController alloc]initWithRootViewController:commentsVC];
    commentsVC.comId = self.comId;
    [self presentViewController:comNav animated:YES completion:^{
        
    }];

}

//- (void)shareBtnClicked:(UIButton *)btn
//{
//
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"55024ec5fd98c5b064000dcc" shareText:@"请写下想要分享的内容..." shareImage:nil  shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQzone,UMShareToEmail, nil] delegate:self];
//   
//  
// 
//}
//- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    if (response.responseCode ==UMSResponseCodeSuccess) {
////        NSLog(@"share to sns name is %@",[[response.data allKeys]objectAtIndex:0]);
//    }
//}
- (void)downloadBtnClicked:(UIButton *)btn
{
    
#pragma mark-----------将图片保存在相册里

     int a =  _containScrollView.contentOffset.x/ViewWidth;
    UIImageView *imageView=(UIImageView *)_imagesArray[a];
      UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
   
#pragma mark-------------将图片缓存在本地沙盒里
//    NSFileManager *manager=[NSFileManager defaultManager];
//    
//    NSArray *cachePaths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    
//    NSString *path=[cachePaths objectAtIndex:0];
//    
//
//    
//    NSString * imgPath=[path stringByAppendingPathComponent:@"/Picture"];
//   
//    [manager createDirectoryAtPath:imgPath withIntermediateDirectories:YES attributes:nil error:nil];
//    NSLog(@"path = %@",imgPath);
//    int a =  _containScrollView.contentOffset.x/ViewWidth;
//    NSLog(@"%d",a);
//   // NSLog(@"%@",_imagesArray);
//    UIImageView * imageView = (UIImageView *)_imagesArray[a];
//    NSData *imgData=UIImageJPEGRepresentation(imageView.image, 1);
//    NSLog(@"%@",_imageview.image);
//   
//    
//    NSDate * date = [NSDate date];
//    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
//    NSString * A = [NSString stringWithFormat:@"%@.jpg",[dateFormatter stringFromDate:date]];
////    NSString *dateStr=[[dateFormatter stringFromDate:date] stringByAppendingString:@".jpg"];
//    NSString *imagePath=[imgPath stringByAppendingPathComponent:A];
//        [imgData writeToFile:imagePath atomically:YES];
//
    
    

    
    
    
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message=@"hehe";
    if (!error) {
        message=@"成功保存到相册";
    }else
    {
        message=[error description];
    }
//    NSLog(@"message = %@",message);
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
   
    [alertView  show];
    
}
//图片缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView.subviews objectAtIndex:0];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    self.beginPage = scrollView.contentOffset.x/ViewWidth;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageLabel.text=[NSString stringWithFormat:@"%.f/%d",scrollView.contentOffset.x/ViewWidth+1,_num];

    self.endPage = scrollView.contentOffset.x/ViewWidth;
    
//    NSLog(@"b%f,e%f",_beginPage,_endPage);
    
    if (_beginPage != _endPage) {
        NSArray *smallScrollArray=_containScrollView.subviews;
        for (UIScrollView *tem in smallScrollArray) {
            if (scrollView.tag == 1) {
                if ([tem isKindOfClass:[UIScrollView class]]) {
                    tem.zoomScale=1;
                }
            }
        }

    }
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
