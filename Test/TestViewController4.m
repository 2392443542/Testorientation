//
//  TestViewController1.m
//  Test
//
//  Created by liwenjing on 2020/9/10.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import "TestViewController4.h"
#import "TestViewController5.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface TestViewController4 ()

@end

@implementation TestViewController4

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [AppDelegate switchToLandscape];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
//    TestViewController5 *test5 = [[TestViewController5 alloc] init];
//    test5.view.bounds = self.view.bounds;
//    [self addChildViewController:test5];
//    [self.view addSubview:test5.view];
   
}

- (void)ss {
//    UIView *fromView = [UIView ];
//    [UIView transitionFromView:<#(nonnull UIView *)#> toView:<#(nonnull UIView *)#> duration:<#(NSTimeInterval)#> options:<#(UIViewAnimationOptions)#> completion:<#^(BOOL finished)completion#>]
}

//- (BOOL)shouldAutorotate {
//    return YES;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscape;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationLandscapeRight;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
