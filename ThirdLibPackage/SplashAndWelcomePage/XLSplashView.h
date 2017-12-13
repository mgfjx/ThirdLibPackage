//
//  XLSplashView.h
//  test
//
//  Created by mgfjx on 2017/12/8.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapCallback)(NSString *link);

@interface XLSplashView : UIView

+ (instancetype)shareInstance;

- (void)showOnWindow:(UIWindow *)window countDownCompleted:(TapCallback)callback ;

@property (nonatomic, assign) NSInteger countNumber ;
// 图片地址
@property (nonatomic, strong) NSString *imgUrl ;
// 若点击图片后需指定跳转，则需设置该属性
@property (nonatomic, strong) NSString *link ;

@end
