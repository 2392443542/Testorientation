//
//  AppDelegate.m
//  Test
//
//  Created by liwenjing on 2020/4/27.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TestTabBarController.h"
#import <RTRootNavigationController/RTRootNavigationController.h>
#import "TestNavigationController.h"
#import "RTestNavigationController.h"
#import "TestViewController.h"
#import "TestViewController2.h"
#import "TestViewController3.h"
#import "PPTestTabBarController.h"
#import "UINavigationController+HXSafeTransition.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)instace {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];;
   
    [self test1];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    return YES;
}

- (void)test2 {
    self.window.rootViewController = [[PPTestTabBarController alloc] init];
    
}

- (void)test {
    self.window.rootViewController = [[TestTabBarController alloc] init];
}

- (void)test1 {
    
//    [[UINavigationBar appearance] setBarTintColor:UIColor.redColor];
   
    NSArray *vcs = @[[[RTContainerNavigationController alloc] initWithRootViewController:[[TestViewController alloc] init] ],
    [[RTContainerNavigationController alloc] initWithRootViewController:[TestViewController2 new]],
    [[RTContainerNavigationController alloc] initWithRootViewController:[TestViewController3 new]],
                   ];
    NSArray *vcsTitle = @[@"首页",
                          @"上课",
                          @"轻课堂",];
    NSArray *tabbarNormalImages = @[@"lx_tabbar_home_normal",
                                    @"lx_tabbar_have_class_normal",
                                    @"lx_tabbar_literacy_normal",
                                    ];
    NSArray *tabbarSelectedImages = @[@"lx_tabbar_home_selected",
                                      @"lx_tabbar_have_class_selected",
                                      @"lx_tabbar_literacy_selected",
                                     ];

    TestTabBarController *tab = [[TestTabBarController alloc] initWithRootViewControllers:vcs
                                                                            andTitles:vcsTitle
                                                                        andImageNames:tabbarNormalImages
                                                                andImageSelectedNames:tabbarSelectedImages];
//    self.window.rootViewController = tab;
    [self.window setRootViewController:[[RTestNavigationController alloc] initWithRootViewControllerNoWrapping:tab]];
//    self.window
    [self.window makeKeyAndVisible];
}
 
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
   
//    if (self.isFullScreen) {
//        NSLog(@"Window----%d--%@",UIInterfaceOrientationMaskLandscape,window.rootViewController);
//        return UIInterfaceOrientationMaskLandscape;
//    } else {
//        NSLog(@"Window----%d--%@",window.rootViewController.supportedInterfaceOrientations,window.rootViewController);
//        return UIInterfaceOrientationMaskPortrait;
//    };
    return window.rootViewController.supportedInterfaceOrientations;
}

/**
 * 屏幕旋转
 */


// 点击返回旋转到横屏
+ (void)switchToLandscape {
//    [self setScreensDirection:YES];
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
//    AppDelegate.instace.isFullScreen = YES;
}

// 点击返回旋转到竖屏
+ (void)switchToPortrait {
//    [self setScreensDirection:NO];
//    AppDelegate.instace.isFullScreen = NO;
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
}



@end
