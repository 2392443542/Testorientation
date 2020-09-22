//
//  TestViewController5.m
//  Test
//
//  Created by alieen on 2020/9/21.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import "TestViewController5.h"
#import "AppDelegate.h"
#import "TestViewController2.h"

@interface TestViewController5 ()

@end

@implementation TestViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.yellowColor;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button setTitle:@"23456" forState:UIControlStateNormal];
    [button setTintColor:[UIColor redColor]];
    button.titleLabel.tintColor = [UIColor redColor];
    [button.titleLabel setTintColor:[UIColor redColor]];
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(ss) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

- (void)ss {
    
    
//    if (self.callback) {
//        self.callback();
//    }
//    [self dismissViewControllerAnimated:YES completion:nil];
    [AppDelegate switchToLandscape];
    TestViewController2 *testVc = [[TestViewController2 alloc] init];
    [self.navigationController pushViewController:testVc animated:YES];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:testVc];
//    [self presentViewController:navi animated:YES completion:nil];
}
//- (BOOL)shouldAutorotate {
//    return NO;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

@end
