//
//  ViewController.m
//  Test
//
//  Created by liwenjing on 2020/4/27.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import "ViewController.h"
#import "TestNavigationController.h"
#import "TestViewController.h"
#import "TestViewController1.h"
#import "TestViewController2.h"
#import "UIImage+Color.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button setTitle:@"134" forState:UIControlStateNormal];
    [button setTintColor:[UIColor redColor]];
    button.titleLabel.tintColor = [UIColor redColor];
    [button.titleLabel setTintColor:[UIColor redColor]];
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(ss) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

- (void)ss {
        TestViewController *testVc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:testVc animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:testVc animated:YES];
    });
//    TestViewController *testVc = [[TestViewController alloc] init];
//    testVc.callback = ^{
//        [self.navigationController pushViewController:[[TestViewController1 alloc] init] animated:YES];
////        [self presentViewController:[[TestViewController1 alloc] init] animated:YES completion:nil];
//    };
////    [self.navigationController pushViewController:testVc animated:YES];
//
////    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:testVc];
//    [self.navigationController pushViewController:testVc animated:YES];
//    TestViewController1 *testVc1 = [[TestViewController1 alloc] init];
//    [self.navigationController pushViewController:testVc1 animated:YES ];
//    TestViewController2 *testVc2 = [[TestViewController2 alloc] init];
//    [self.navigationController pushViewController:testVc2 animated:YES ];
//        TestViewController *testVc3 = [[TestViewController alloc] init];
//        [self.navigationController pushViewController:testVc3 animated:YES];
//    [self.navigationController pushViewController:testVc animated:YES];
//    [self presentViewController:testVc animated:YES completion:nil];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////          UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:testVc];
//        TestViewController1 *testVc1 = [[TestViewController1 alloc] init];
//           [self presentViewController:testVc1 animated:YES completion:nil];
//    });
}


- (BOOL)shouldAutorotate {
    return self.contentViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.contentViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.contentViewController.preferredInterfaceOrientationForPresentation;
}
@end
