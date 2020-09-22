//
//  TestViewController.m
//  Test
//
//  Created by liwenjing on 2020/9/10.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import "TestViewController.h"
#import "AppDelegate.h"
#import "UIImage+Color.h"
#import "TestViewController4.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//     [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forBarMetrics:UIBarMetricsDefault];
//    [AppDelegate switchToPortrait];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
//    NSLog(@"---%d--%d--%d--%d--%d--%d--%d--%d",UIInterfaceOrientationMaskLandscapeLeft,UIInterfaceOrientationMaskLandscapeRight,UIInterfaceOrientationMaskLandscape,UIInterfaceOrientationMaskPortrait,UIInterfaceOrientationLandscapeLeft,UIInterfaceOrientationLandscapeRight,UIInterfaceOrientationPortraitUpsideDown,UIInterfaceOrientationMaskAll);
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [button setTitle:@"23456" forState:UIControlStateNormal];
//    [button setTintColor:[UIColor redColor]];
//    button.titleLabel.tintColor = [UIColor redColor];
//    [button.titleLabel setTintColor:[UIColor redColor]];
//    button.backgroundColor = [UIColor greenColor];
//    [button addTarget:self action:@selector(ss) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:button];
}


- (void)ss {
    [AppDelegate switchToLandscape];
    
//    if (self.callback) {
//        self.callback();
//    }
//    [self dismissViewControllerAnimated:YES completion:nil];
    TestViewController4 *testVc = [[TestViewController4 alloc] init];
    [self.navigationController pushViewController:testVc animated:YES];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:testVc];
//    [self presentViewController:navi animated:YES completion:nil];
}

//- (BOOL)shouldAutorotate {
//    return YES;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAll;
//}
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
