//
//  PublicDialogManager.m
//  ThirdLibPackage
//
//  Created by mgfjx on 2017/11/11.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import "PublicDialogManager.h"
#import <MBProgressHUD.h>

#define ContentColor [UIColor whiteColor]
#define BackgroundColor [UIColor blackColor]
#define BezelViewMargin 8.0f

@implementation PublicDialogManager

+ (void)showText:(NSString *)text inView:(UIView *)view duration:(CGFloat)duration {
    [self showText:text inView:view duration:duration offset:0.0];
}

+ (void)showText:(NSString *)text inView:(UIView *)view duration:(CGFloat)duration offset:(CGFloat)offset {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"";
    hud.contentColor = ContentColor;
    hud.detailsLabel.text = text;
    hud.margin = BezelViewMargin;
    hud.offset = CGPointMake(0.f, offset);
    hud.bezelView.backgroundColor = BackgroundColor;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:duration];
}

+ (void)showWaittingInView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.backgroundColor = BackgroundColor;
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = ContentColor;
}

+ (void)hideWaittingInView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
