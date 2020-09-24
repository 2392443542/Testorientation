//
//  TestBaseViewController.m
//  Test
//
//  Created by alieen on 2020/9/21.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import "TestBaseViewController.h"
#import <RTRootNavigationController/RTRootNavigationController.h>

@interface TestBaseViewController ()<RTNavigationItemCustomizable>

@end

@implementation TestBaseViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [AppDelegate switchToLandscape];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    NSLog(@"%@",NSStringFromClass(self.class));
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 250, 150)];
    [button setTitle:NSStringFromClass(self.class) forState:UIControlStateNormal];
    [button setTintColor:[UIColor redColor]];
    button.titleLabel.tintColor = [UIColor redColor];
    [button.titleLabel setTintColor:[UIColor redColor]];
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(ss) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}
//
//- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
////    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [backButton setBackgroundColor:[UIColor clearColor]];
//    [backButton setImage:[UIImage imageNamed:@"navigationBar_back"] forState:UIControlStateNormal];
//    [backButton setImage:[UIImage imageNamed:@"navigationBar_back"] forState:UIControlStateHighlighted];
//    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    self.navigationItem.leftBarButtonItem = item;
//    return item;
//}
- (void)popSelf {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ss {
    
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
