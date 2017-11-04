//
//  RefreshScrollView.m
//  test
//
//  Created by mgfjx on 2017/11/3.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import "RefreshScrollView.h"
#import <MJRefresh.h>

@implementation RefreshScrollView

- (void)setCanPullDown:(BOOL)canPullDown {
    _canPullDown = canPullDown;
    if (_canPullDown) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
        header.lastUpdatedTimeLabel.hidden = YES;
        
        self.mj_header = header;
    }
}

- (void)setCanPullUp:(BOOL)canPullUp {
    _canPullUp = canPullUp;
    if (_canPullUp) {
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
        self.mj_footer = footer;
    }
}

- (void)headerRefreshing {
    if (self.mj_delegate && [self.mj_delegate respondsToSelector:@selector(headerRefreshing:)]) {
        [self.mj_delegate headerRefreshing:self];
    }
}

- (void)footerRefreshing {
    if (self.mj_delegate && [self.mj_delegate respondsToSelector:@selector(footerRefreshing:)]) {
        [self.mj_delegate footerRefreshing:self];
    }
}

- (void)startHeaderRefreshing {
    [self.mj_header beginRefreshing];
}

- (void)startFooterRefreshing {
    [self.mj_footer beginRefreshing];;
}

- (void)stopHeaderRefreshing {
    [self.mj_header endRefreshing];
}

- (void)stopFooterRefreshing {
    [self.mj_footer endRefreshing];
}

- (void)dealloc {
    NSLog(@"%@",NSStringFromClass([self class]));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        UIResponder *responder = [self nextResponder];
        while (responder) {
            if ([responder isKindOfClass:[UIViewController class]]) {
                UIViewController *vc = (UIViewController *)responder;
                vc.automaticallyAdjustsScrollViewInsets = NO;
                break;
            }else{
                responder = [responder nextResponder];
            }
        }
    }
}

@end
