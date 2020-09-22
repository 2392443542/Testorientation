//
//  TestNavigationController.m
//  Test
//
//  Created by liwenjing on 2020/9/11.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import "TestNavigationController.h"



@interface TestNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation TestNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
  
//     self.interactivePopGestureRecognizer.delegate = self;
//     self.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationBar.translucent = NO;
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (self.viewControllers.count > 0){
//        viewController.hidesBottomBarWhenPushed = YES;
////        [viewController setDefaultBackItem];
//    }
//    [super pushViewController:viewController animated:animated];
//}

//- (BOOL)shouldAutorotate {
//    return [self.topViewController shouldAutorotate];
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscapeLeft;
////    [self.topViewController supportedInterfaceOrientations];
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationLandscapeLeft;
////    [self.topViewController preferredInterfaceOrientationForPresentation];
//}


@end
