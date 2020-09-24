//
//  RTestNavigationController.m
//  Test
//
//  Created by alieen on 2020/9/22.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import "RTestNavigationController.h"

@interface RTestNavigationController () <UINavigationControllerDelegate>

@property (nonatomic,assign) BOOL viewTransitionInProgress;

@end

@implementation RTestNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [super setDelegate:self];
//    self.delegate = self;
//    UIImage *backButtonImage = [[UIImage imageNamed:@"lx_navmenu_back_black"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)];

//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

#pragma mark - Intercept Pop, Push, PopToRootVC
/// @name Intercept Pop, Push, PopToRootVC
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    if (self.viewTransitionInProgress) return nil;
    if (animated) {
        self.viewTransitionInProgress = YES;
    }
    //-- This is not a recursion, due to method swizzling the call below calls the original  method.
    return [super popToRootViewControllerAnimated:animated];
//    return [self safePopToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewTransitionInProgress) return nil;
    if (animated) {
        self.viewTransitionInProgress = YES;
    }
    //-- This is not a recursion, due to method swizzling the call below calls the original  method.
    return [super popToViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if (self.viewTransitionInProgress) return nil;
    if (animated) {
        self.viewTransitionInProgress = YES;
    }
    //-- This is not a recursion, due to method swizzling the call below calls the original  method.
    return [super popViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
 
    //-- If we are already pushing a view controller, we dont push another one.
    if (self.viewTransitionInProgress == NO) {
        //-- This is not a recursion, due to method swizzling the call below calls the original  method.
       
        [super pushViewController:viewController animated:animated];
        if (animated) {
            NSLog(@"---%@",viewController.class);
            self.viewTransitionInProgress = YES;
           
        }
//        [CATransaction setCompletionBlock:^{
//            self.viewTransitionInProgress = NO;
//        }];
        
    }
}

#pragma mark - UINavigationController Delegate

 // If the user doesnt complete the swipe-to-go-back gesture, we need to intercept it and set the flag to NO again.
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super navigationController:navigationController willShowViewController:viewController animated:animated];
    id<UIViewControllerTransitionCoordinator> tc = navigationController.topViewController.transitionCoordinator;
    [tc notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.viewTransitionInProgress = NO;
        //--Reenable swipe back gesture.
//        self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)viewController;
//        [self.interactivePopGestureRecognizer setEnabled:YES];
    }];
    //-- Method swizzling wont work in the case of a delegate so:
    //-- forward this method to the original delegate if there is one different than ourselves.
    if (navigationController.delegate != self) {
        [navigationController.delegate navigationController:navigationController
                                     willShowViewController:viewController
                                                   animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController
      didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    [super navigationController:navigationController didShowViewController:viewController animated:animated];
    self.viewTransitionInProgress = NO;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
