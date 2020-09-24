//
//  TestNavigationController.m
//  Test
//
//  Created by liwenjing on 2020/9/11.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import "TestNavigationController.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

#import "ViewController.h"

@interface TestNavigationController ()

@end

@implementation TestNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
   
  
//     self.interactivePopGestureRecognizer.delegate = self;
//     self.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//  
//    if (self.viewControllers.count > 0){
//        TestNavigationController *navi = [[TestNavigationController alloc] init];
//        navi.viewControllers = @[viewController];
//        ViewController *vc = [[ViewController alloc] init];
//        vc.contentViewController = viewController;
//        [vc.view addSubview:navi.view];
//        [vc addChildViewController:navi];
//        viewController.hidesBottomBarWhenPushed = YES;
//        [super pushViewController:vc animated:animated];
//        return;
////        [viewController setDefaultBackItem];
//    }
    [super pushViewController:viewController animated:animated];
//    void* callstack[128];
//    int frames = backtrace(callstack, 128);
//    char **strs = backtrace_symbols(callstack, frames);
//    int i;
//    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
//    for (i = 0;i < 4;i++){
//        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
//    }
//    free(strs);
//    NSLog(@"=====>>>>>堆栈<<<<<=====\n%@",backtrace);
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return  [super popViewControllerAnimated:animated];
}

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscapeLeft;
  return  [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationLandscapeLeft;
    return  [self.topViewController preferredInterfaceOrientationForPresentation];
}


@end
