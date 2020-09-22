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
#import "TestNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)instace {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];;
    TestTabBarController *tabbar = [[TestTabBarController alloc] init];
   
    [self.window setRootViewController:[[TestNavigationController alloc] initWithRootViewControllerNoWrapping:tabbar]];
    NSLog(@"---%@",tabbar);
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
   
//    if (self.isFullScreen) {
//        NSLog(@"Window----%d--%@",UIInterfaceOrientationMaskLandscape,window.rootViewController);
//        return UIInterfaceOrientationMaskLandscape;
//    } else {
        NSLog(@"Window----%d--%@",window.rootViewController.supportedInterfaceOrientations,window.rootViewController);
//        return UIInterfaceOrientationMaskPortrait;
//    };
    return window.rootViewController.supportedInterfaceOrientations;
}

/**
 * 屏幕旋转
 */
- (void)deviceOrientationChange:(NSNotification *)noti {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeRight ||
        orientation == UIDeviceOrientationLandscapeLeft) {
//        self.currentOrientation = orientation;
    }
}


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
