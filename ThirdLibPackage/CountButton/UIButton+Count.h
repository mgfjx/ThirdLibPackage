//
//  UIButton+Count.h
//  ThirdLibPackage
//
//  Created by mgfjx on 2017/11/6.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CountDownCompletion)(UIButton *sender, NSUInteger countNumber);
typedef void(^CountDownStateCallback)(UIButton *sender);

@interface UIButton (Count)

@property (nonatomic, assign) BOOL countDownable ;

- (void)setCounter:(NSUInteger)countNumber begin:(CountDownStateCallback)beginCallback counting:(CountDownCompletion)countingCallback end:(CountDownStateCallback)endCallback ;

- (void)stopCounter ;

@end
