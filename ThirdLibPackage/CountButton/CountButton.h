//
//  CountButton.h
//  ThirdLibPackage
//
//  Created by mgfjx on 2017/11/7.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CountDownCompletion)(UIButton *sender, NSUInteger countNumber);
typedef void(^CountDownStateCallback)(UIButton *sender);

@interface CountButton : UIButton

@property (nonatomic, assign) BOOL countDownable ;

- (void)startCounter:(NSUInteger)countNumber begin:(CountDownStateCallback)beginCallback counting:(CountDownCompletion)countingCallback end:(CountDownStateCallback)endCallback ;

- (void)stopCounter ;

@end
