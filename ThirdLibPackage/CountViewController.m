//
//  CountViewController.m
//  ThirdLibPackage
//
//  Created by mgfjx on 2017/11/6.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import "CountViewController.h"
//#import "UIButton+Count.h"
#import "CountButton.h"

@interface CountViewController ()
@property (weak, nonatomic) IBOutlet CountButton *btn;
@property (nonatomic, strong) dispatch_source_t timer ;

@end

@implementation CountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn.countDownable = YES;
    
    [self.btn setCounter:3 begin:^(UIButton *sender) {
        sender.userInteractionEnabled = NO;
        sender.backgroundColor = [UIColor lightGrayColor];
    } counting:^(UIButton *sender, NSUInteger countNumber) {
        NSString *string = [NSString stringWithFormat:@"%lu秒", countNumber];
        [sender setTitle:string forState:UIControlStateNormal];
    } end:^(UIButton *sender) {
        sender.userInteractionEnabled = YES;
        [sender setTitle:@"click" forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithHexString:@"#1799d4"];
    }];
    
}

- (IBAction)clicked:(UIButton *)sender {
//    [self.btn stopCounter];
    [self.btn removeFromSuperview];
    
}

@end
