//
//  XLWelcomePageView.m
//  ThirdLibPackage
//
//  Created by mgfjx on 2017/12/12.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import "XLWelcomePageView.h"

@interface XLWelcomePageView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView ;
@property (nonatomic, strong) UIWindow *window ;
@property (nonatomic, strong) NSArray *imageNames ;
@property (nonatomic, strong) UIPageControl *pageControl ;

@end

@implementation XLWelcomePageView

+ (void)showWelcomePageOnWindow:(UIWindow *)window imageNames:(NSArray *)imageNames  {
    
    XLWelcomePageView *welcomePage = [[XLWelcomePageView alloc] init];
    welcomePage.imageNames = imageNames;
    welcomePage.window = window;
    [welcomePage setViews];
    
}

- (void)setViews {
    
    if (self.imageNames.count == 0) {
        return;
    }
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    self.frame = CGRectMake(0, 0, width, height);
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.contentSize = CGSizeMake(width*self.imageNames.count, height);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    _scrollView = scrollView;
    
    for (int i = 0; i < self.imageNames.count; i++) {
        NSString *imageName = self.imageNames[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*width, 0, width, height)];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [_scrollView addSubview:imageView];
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height - 100, width, 40)];
    pageControl.numberOfPages = self.imageNames.count;
    pageControl.currentPage = 0;
    pageControl.hidesForSinglePage = YES;
    [self addSubview:pageControl];
    [pageControl addTarget:self action:@selector(pageControlCLicked:) forControlEvents:UIControlEventValueChanged];
    _pageControl = pageControl;
    
    self.window.windowLevel = UIWindowLevelStatusBar;
    [self.window addSubview:self];
}

- (void)pageControlCLicked:(UIPageControl *)pageControl {
    self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width * pageControl.currentPage, 0);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = (NSInteger)_scrollView.contentOffset.x/scrollView.frame.size.width ;
    _pageControl.currentPage = page;
}

@end
