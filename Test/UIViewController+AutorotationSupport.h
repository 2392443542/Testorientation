//
//  UIViewController+AutorotationSupport.h
//  MobMathApp
//
//  Created by Hasayakey on 2020/6/8.
//  Copyright © 2020 河小象. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern BOOL isUserInterfaceIdiomPhone(void);

/// 全局统一默认页面是否支持旋转和横屏
/// 默认情况下是不支持旋转的
/// 如果你自定义了旋转相关的属性，那么会根据你自定义的来
@interface UIViewController (AutorotationSupport)

@end

NS_ASSUME_NONNULL_END
