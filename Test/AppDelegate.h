//
//  AppDelegate.h
//  Test
//
//  Created by liwenjing on 2020/4/27.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;
@property (nonatomic, assign) BOOL isFullScreen;
+ (instancetype)instace;
/**
 * 屏幕旋转
 */
+ (void)switchToLandscape;
+ (void)switchToPortrait;


@end

