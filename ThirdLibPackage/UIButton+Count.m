//
//  UIButton+Count.m
//  ThirdLibPackage
//
//  Created by mgfjx on 2017/11/6.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import "UIButton+Count.h"
#import <objc/runtime.h>

@interface UIButton()

@property (nonatomic, assign) NSUInteger countNumber ;
@property (nonatomic, copy) CountDownCompletion countDownCallback ;
@property (nonatomic, copy) CountDownStateCallback countBeginCallback ;
@property (nonatomic, copy) CountDownStateCallback countEndCallback ;
@property (nonatomic, strong) dispatch_source_t timer ;

@end

@implementation UIButton (Count)

const char *countNumberKey = "countNumberKey";
- (void)setCountNumber:(NSUInteger)countNumber {
    objc_setAssociatedObject(self, countNumberKey, @(countNumber), OBJC_ASSOCIATION_ASSIGN);
}

- (NSUInteger)countNumber {
    return [objc_getAssociatedObject(self, countNumberKey) integerValue];
}

const char *countDownableKey = "countDownableKey";
- (void)setCountDownable:(BOOL)countDownable {
    objc_setAssociatedObject(self, countDownableKey, @(countDownable), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)countDownable {
    return [objc_getAssociatedObject(self, countDownableKey) boolValue];
}

const char *countDownCallbackKey = "countDownCallbackKey";
- (void)setCountDownCallback:(CountDownCompletion)countDownCallback {
    objc_setAssociatedObject(self, countDownCallbackKey, countDownCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CountDownCompletion)countDownCallback {
    return objc_getAssociatedObject(self, countDownCallbackKey);
}

const char *countEndCallbackKey = "countEndCallback";
- (void)setCountEndCallback:(CountDownStateCallback)countEndCallback {
    objc_setAssociatedObject(self, countEndCallbackKey, countEndCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CountDownStateCallback)countEndCallback {
    return objc_getAssociatedObject(self, countEndCallbackKey);
}

const char *countBeginCallbackKey = "countBeginCallbackKey";
- (void)setCountBeginCallback:(CountDownStateCallback)countBeginCallback {
    objc_setAssociatedObject(self, countBeginCallbackKey, countBeginCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CountDownStateCallback)countBeginCallback {
    return objc_getAssociatedObject(self, countBeginCallbackKey);
}

const char *timerKey = "timerKey";
- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, timerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)timer {
    return objc_getAssociatedObject(self, timerKey);
}

+ (void)load {
    Method m1 = class_getInstanceMethod([self class], @selector(beginTrackingWithTouch:withEvent:));
    Method m2 = class_getInstanceMethod([self class], @selector(xl_beginTrackingWithTouch:withEvent:));
    method_exchangeImplementations(m1, m2);
    
}

- (BOOL)xl_beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    
    BOOL shouldCount = NO;
    if (self.countDownable) {
        if (self.countNumber > 0) {
            shouldCount = YES;
        }
    }
    
    if (shouldCount) {
        [self createTimer];
    }
    
    return [self xl_beginTrackingWithTouch:touch withEvent:event];
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

- (void)stopCounter {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
}

- (void)setCounter:(NSUInteger)countNumber begin:(CountDownStateCallback)beginCallback counting:(CountDownCompletion)countingCallback end:(CountDownStateCallback)endCallback {
    self.countNumber = countNumber;
    self.countBeginCallback = beginCallback;
    self.countDownCallback = countingCallback;
    self.countEndCallback = endCallback;
}

@end
