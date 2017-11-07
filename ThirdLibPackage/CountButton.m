//
//  CountButton.m
//  ThirdLibPackage
//
//  Created by mgfjx on 2017/11/7.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import "CountButton.h"

@interface CountButton()

@property (nonatomic, assign) NSUInteger countNumber ;
@property (nonatomic, copy) CountDownCompletion countDownCallback ;
@property (nonatomic, copy) CountDownStateCallback countBeginCallback ;
@property (nonatomic, copy) CountDownStateCallback countEndCallback ;
@property (nonatomic, strong) dispatch_source_t timer ;

@end

@implementation CountButton

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    BOOL shouldCount = NO;
    if (self.countDownable) {
        if (self.countNumber > 0) {
            shouldCount = YES;
        }
    }
    
    if (shouldCount) {
        [self createTimer];
    }
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (void)createTimer {
    __block typeof(self) weakSelf = self;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    self.timer = timer;
    __block NSUInteger countNum = self.countNumber;
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (countNum == weakSelf.countNumber) {
            if (weakSelf.countBeginCallback) {
                weakSelf.countBeginCallback(weakSelf);
            }
        }
        
        if (countNum == 0) {
            dispatch_source_cancel(weakSelf.timer);
            weakSelf.timer = nil;
            if (weakSelf.countEndCallback) {
                weakSelf.countEndCallback(weakSelf);
            }
            return;
        }
        
        if (weakSelf.countDownCallback) {
            weakSelf.countDownCallback(weakSelf, countNum);
        }
        countNum --;
    });
    dispatch_resume(timer);
}

- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (void)removeFromSuperview {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
    [super removeFromSuperview];
}

- (void)setCounter:(NSUInteger)countNumber begin:(CountDownStateCallback)beginCallback counting:(CountDownCompletion)countingCallback end:(CountDownStateCallback)endCallback {
    self.countNumber = countNumber;
    self.countBeginCallback = beginCallback;
    self.countDownCallback = countingCallback;
    self.countEndCallback = endCallback;
}

@end
