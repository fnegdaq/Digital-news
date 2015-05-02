//
//  BYSelectionView.h
//  BYDailyNews
//
//  Created by bassamyan on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News_HomePageViewController.h"
typedef enum{
    top = 0,
    bottom = 1
}itemLocation;

@protocol passCountDelegate <NSObject>

- (void)passCount:(NSInteger)count;

@end


@interface BYListItem : UIButton
{
    @public
    NSMutableArray *locateView;
    NSMutableArray *topView;
    NSMutableArray *bottomView;
}

@property (nonatomic,assign)id<passCountDelegate>delegate;

@property (nonatomic,strong) UIView   *hitTextLabel;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIButton *hiddenBtn;
@property (nonatomic,assign) itemLocation location;
@property (nonatomic,copy) NSString *itemName;
@property (nonatomic,assign) int count;
@property (nonatomic,assign) NSInteger buttonCount;

@property (nonatomic,copy) void(^longPressBlock)();
@property (nonatomic,copy) void(^operationBlock)(animateType type, NSString *itemName, int index);


@property (nonatomic,strong) UIPanGestureRecognizer *gesture;
@property (nonatomic,strong) UILongPressGestureRecognizer *longGesture;

@end
