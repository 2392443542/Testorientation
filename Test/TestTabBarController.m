//
//  TestTabBarController.m
//  Test
//
//  Created by liwenjing on 2020/9/17.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import "TestTabBarController.h"
#import "TestNavigationController.h"

@interface TestTabBarController ()<UITabBarControllerDelegate>

@end

@implementation TestTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//
}

+ (NSArray<NSArray *> *)getTabBarMenus {
    return @[@[@"首页",@"tab_bar_menu_home",@"TestViewController",@(YES)],
             @[@"课程",@"tab_bar_menu_schedule",@"TestViewController2",@(YES)],
             @[@"我的",@"tab_bar_menu_me",@"TestViewController3",@(NO)]
    ];
}

- (void)setupSubControllers {
    NSMutableArray *pages = [NSMutableArray arrayWithCapacity:0];
    NSArray *tabBarMenus = [TestTabBarController getTabBarMenus];
    [tabBarMenus enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // MARK : 0 - 标题 1 - 图片  2 - 控制器  3 - 是否需要导航控制器
        NSString *title = obj.firstObject;
        NSString *imageName = obj[1];
        NSString *selImageName = [NSString stringWithFormat:@"%@_sel",imageName];
        NSString *className = obj[2];
        // BOOL showTitle = [obj[3] boolValue];
        
        Class class = NSClassFromString(className);
        id childVC = [class alloc];
        if ([childVC isKindOfClass:[UITableViewController class]]) {
            childVC = [childVC initWithStyle:UITableViewStyleGrouped];
        } else {
            childVC = [childVC init];
        }
        if ([childVC isKindOfClass:[UIViewController class]]) {
            UIViewController *page = (UIViewController *)childVC;
//            page.view.backgroundColor = UIColo
            TestNavigationController *navi = [[TestNavigationController alloc] initWithRootViewController:childVC];
//            navi.fullScreenPopGestureEnabled = YES;
            page = navi;
            page.tabBarItem.title = title;
            page.tabBarItem.tag = idx;
            page.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            page.tabBarItem.selectedImage = [[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            NSDictionary *selectAtt = @{
                NSForegroundColorAttributeName:[UIColor redColor],
                NSFontAttributeName:[UIFont boldSystemFontOfSize:11]
            };
            NSDictionary *normalAtt = @{
                NSForegroundColorAttributeName:[UIColor greenColor],
                NSFontAttributeName:[UIFont boldSystemFontOfSize:11]
            };
            [page.tabBarItem setTitleTextAttributes:selectAtt forState:UIControlStateSelected];
            [page.tabBarItem setTitleTextAttributes:normalAtt forState:UIControlStateNormal];
            [pages addObject:page];
            [self addChildViewController:navi];
        }
       
    }];
//    self.viewControllers = pages;
//    self.delegate = self;
    [self tabBarController:self didSelectViewController:self.viewControllers.firstObject];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(__kindof UIViewController *)viewController {
    @try {
        NSMutableArray *items = [NSMutableArray array];
        for (UIView *item in self.tabBar.subviews) {
            if ([item isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [items addObject:item];
            }
        }
        NSUInteger selectIdx = self.selectedIndex;
        if (selectIdx < items.count) {
//            [items[selectIdx] addTapScaleSpringAnimation];
        }
        self.navigationItem.title = viewController.navigationItem.title?:viewController.title;
        
    } @catch (NSException *exception) {
        NSLog(@"tabBarController didSelectViewController error : %@",exception.userInfo);
    } @finally {
        
    }
}

- (instancetype)initWithRootViewControllers:(NSArray *)controllers
                                  andTitles:(NSArray *)titles
                              andImageNames:(NSArray *)imageNames
                      andImageSelectedNames:(NSArray *)imageSelectedNames {
    if (self = [super init]) {
        for (NSInteger i = 0; i < controllers.count; i++) {
            [self addChildViewController:controllers[i]
                               withImage:[UIImage imageNamed:imageNames[i]]
                           selectedImage:[UIImage imageNamed:imageSelectedNames[i]]
                              withTittle:titles[i]];
        }
    }
    return self;
}

- (void)addChildViewController:(UIViewController *)controller
                     withImage:(UIImage *)image
                 selectedImage:(UIImage *)selectImage
                    withTittle:(NSString *)tittle {
//    LXNavigationController *navigationController = [[LXNavigationController alloc] initWithRootViewController:controller];

    [controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColor.redColor, NSForegroundColorAttributeName, nil]
                                         forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColor.greenColor, NSForegroundColorAttributeName, nil]
                                         forState:UIControlStateSelected];

    controller.tabBarItem.title = tittle;
    controller.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [self addChildViewController:controller];
}

#pragma mark - UIViewControllerRotation

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationLandscapeLeft;
    return   self.selectedViewController.preferredInterfaceOrientationForPresentation;
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
