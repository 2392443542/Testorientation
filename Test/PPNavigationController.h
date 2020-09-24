//
//  PPNavigationController.h
//  MobYuWenApp
//
//  Created by 王振兴 on 2019/9/16.
//  Copyright © 2019 杭州河象网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * PPContainerViewController
 */
@interface PPContainerViewController : UIViewController
    
@property (nonatomic, readonly) UIViewController *rootViewController;
    
+ (PPContainerViewController *)containerViewControllerWithViewController:(UIViewController *)viewController;
    
@end

/**
 * PPNavigationController
 */
@interface PPNavigationController : UINavigationController

// TODO : 可以考虑将此属性交给每个控制器控制
@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;
// MARK : 返回按钮
@property (nonatomic, class) NSString *ppDefaultBackImageName;
// MARK : 子控制器
@property (nonatomic, readonly) NSArray *ppViewControllers;

+ (BOOL)ppNavigationStyleEnable;

@end

/**
 * UIViewController(NSCopying)
 */
@interface UIViewController(PPNavigationController)<NSCopying>
    
@property (nonatomic, assign) BOOL ppFullScreenPopGestureEnabled;

@property (nonatomic, weak, nullable) PPNavigationController *ppNavigationController;

@property (nonatomic, copy, nullable) void(^popCallback)(void);

- (void)setDefaultBackItem;

@end

@interface UINavigationController(PPNavigationController)

@end



NS_ASSUME_NONNULL_END
