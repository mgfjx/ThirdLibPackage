//
//  PublicDefine.h
//  ThirdLibPackage
//
//  Created by mgfjx on 2019/5/23.
//  Copyright © 2019 mgfjx. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h

#define  MAIN_HEIGHT                  [UIScreen mainScreen].bounds.size.height
#define  MAIN_WIDTH                   [UIScreen mainScreen].bounds.size.width
#define  iPhoneX                      ((MAIN_HEIGHT == 896.f || MAIN_HEIGHT == 812.f) ? YES : NO)
#define  kStatusBar_Height            (iPhoneX  ? 44  : 20)
#define  kNavigation_Height           44
#define  kNavigationBar_Height        kStatusBar_Height + kNavigation_Height
#define  kTabBar_Height               (iPhoneX ? 83 : 49)

#endif /* PublicDefine_h */
