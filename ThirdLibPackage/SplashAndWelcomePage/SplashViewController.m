//
//  SplashViewController.m
//  ThirdLibPackage
//
//  Created by mgfjx on 2017/12/12.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import "SplashViewController.h"
#import "XLSplashView.h"
#import "XLWelcomePageView.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)show:(id)sender {
    
    [XLSplashView shareInstance].imgUrl = @"http://sjbz.fd.zol-img.com.cn/t_s768x1280c/g5/M00/05/03/ChMkJlgTTCOIAQaWAAhPEW0dTD0AAXR2gKZvccACE8p116.jpg";
    [[XLSplashView shareInstance] showOnWindow:[UIApplication sharedApplication].keyWindow countDownCompleted:^(NSString *link) {
        NSLog(@"%@", link);
    }];
    
}

- (IBAction)showWelcome:(id)sender {
    
    XLWelcomePageView * view = [[XLWelcomePageView alloc] init];
    NSLog(@"%@", view);
    
}

@end
