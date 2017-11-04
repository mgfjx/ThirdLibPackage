//
//  ViewController.m
//  ThirdLibPackage
//
//  Created by mgfjx on 2017/11/4.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import "ViewController.h"
#import "RefreshScrollView.h"
#import "UIScrollView+Refresh.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initScrollView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(setPropertys:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:button];
    
}

- (void)setPropertys:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    self.scrollView.canPullUp = sender.selected;;
//    self.scrollView.canPullDown = !sender.selected;
    
    NSLog(@"1%@", _scrollView);
    [_scrollView removeFromSuperview];
    _scrollView = nil;
    NSLog(@"2%@", _scrollView);
}

- (void)initScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor randomColor];
    _scrollView = scrollView;
    scrollView.canPullUp = YES;

    scrollView.headerRefreshBlock = ^(UIScrollView *rfScrollView) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:2];
            dispatch_async(dispatch_get_main_queue(), ^{
                [rfScrollView stopHeaderRefreshing];
            });
        });
    };

    scrollView.footerRefreshBlock = ^(UIScrollView *rfScrollView){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:2];
            dispatch_async(dispatch_get_main_queue(), ^{
                [rfScrollView stopFooterRefreshing];
            });
        });
    };

    scrollView.canPullDown = YES;
    [self.view addSubview:scrollView];
    
    UIView *view = [[UIView alloc] initWithFrame:scrollView.bounds];
    view.height = view.height * 2;
    view.backgroundColor = [UIColor randomColor];
    [scrollView addSubview:view];

    scrollView.contentSize = CGSizeMake(scrollView.width, view.height);
}

@end
