//
//  PPNavigationController.m
//  MobYuWenApp
//
//  Created by 王振兴 on 2019/9/16.
//  Copyright © 2019 杭州河象网络科技有限公司. All rights reserved.
//

#import "PPNavigationController.h"
#import <objc/runtime.h>

//#import "UIViewController+PPExtension.h"
//#import "NSUserDefaults+PPExtension.h"
//#import "PPModule.h"
//#import "PPNavigationBar.h"
//#import "UIDevice+PPExtension.h"

#pragma mark - PPContainerNavigationController

@interface PPContainerNavigationController : UINavigationController <UINavigationControllerDelegate>


@end

@implementation PPContainerNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    @try {
        PPNavigationController *ppNavigationController = viewController.ppNavigationController;
        NSArray<UIViewController *> *childVCs = ppNavigationController.ppViewControllers;
        NSInteger index = NSNotFound;
        if (viewController) {
            index = [childVCs indexOfObject:viewController];
        }
        if (index == NSNotFound) {
            index = MAX(0, childVCs.count - 1);
        }
        if (index < ppNavigationController.viewControllers.count) {
            viewController = [ppNavigationController.viewControllers objectAtIndex:index];
        } else {
            return @[];
        }
    } @catch (NSException *exception) {
        NSLog(@"PPContainerNavigationController popToViewController Exception : %@",exception);
    }
    return [self.navigationController popToViewController:viewController animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.ppNavigationController = (PPNavigationController *)self.navigationController;
    viewController.hidesBottomBarWhenPushed = YES;
//    [viewController setDefaultBackItem];
    [self.navigationController pushViewController:[PPContainerViewController containerViewControllerWithViewController:viewController] animated:animated];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0 && !obj.navigationItem.leftBarButtonItem) {
            [obj setDefaultBackItem];
        }
    }];
    [super setViewControllers:viewControllers];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.ppNavigationController = nil;
}

- (void)didClickLeftItem:(UIBarButtonItem *)leftItem {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

#pragma mark - PPContainerViewController

@interface PPContainerViewController()


@end

@implementation PPContainerViewController

+ (PPContainerViewController *)containerViewControllerWithViewController:(UIViewController *)viewController {
    PPContainerNavigationController *containerNavi = [[PPContainerNavigationController alloc] initWithNavigationBarClass:[UINavigationBar class] toolbarClass:[UIToolbar class]];
    containerNavi.viewControllers = @[viewController];
    PPContainerViewController *containerVC = [[PPContainerViewController alloc] init];
    [containerVC.view addSubview:containerNavi.view];
    [containerVC addChildViewController:containerNavi];
    return containerVC;
}

- (id)copyWithZone:(NSZone *)zone {
    PPContainerViewController *containerVC = [[PPContainerViewController allocWithZone:zone] init];
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isMemberOfClass:[PPContainerNavigationController class]]) {
            PPContainerNavigationController *containerNavi = [obj copy];
            [containerVC.view addSubview:containerNavi.view];
            [containerVC addChildViewController:containerNavi];
        }
    }];
    return containerVC;
}

- (BOOL)ppFullScreenPopGestureEnabled {
    return [self rootViewController].ppFullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    PPContainerNavigationController *containerNavController = self.childViewControllers.firstObject;
    return [containerNavController.viewControllers lastObject];
}

- (BOOL)shouldAutorotate {
    return [[self rootViewController] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[self rootViewController] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [[self rootViewController] preferredInterfaceOrientationForPresentation];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return [[self rootViewController] prefersHomeIndicatorAutoHidden];
}

@end

#pragma mark - PPNavigationController

@interface PPNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

// MARK : Gesture
@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;
@property (nonatomic, strong) id popGestureDelegate;

// MARK : Layer
// @property (nonatomic, strong) CALayer *navigationLayer;

@end


@implementation PPNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithNavigationBarClass:[UINavigationBar class] toolbarClass:[UIToolbar class]]) {
        self.viewControllers = @[rootViewController];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setViewControllers:self.viewControllers];
    }
    return self;
}

- (NSArray<__kindof PPContainerViewController *> *)getContainersByControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    NSMutableArray<__kindof UIViewController *> *controllers = [NSMutableArray arrayWithCapacity:0];
    [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([PPNavigationController ppNavigationStyleEnable] && ![obj isMemberOfClass:[PPContainerViewController class]]) {
            UIViewController *containerVC = [PPContainerViewController containerViewControllerWithViewController:obj];
            [controllers addObject:containerVC];
        } else {
            if (idx > 0 && !obj.navigationItem.leftBarButtonItem) {
                [obj setDefaultBackItem];
            }
            [controllers addObject:obj];
        }
    }];
    self.viewControllers.firstObject.ppNavigationController = self;
    return [controllers copy];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [super setViewControllers:[self getContainersByControllers:viewControllers]];
} 

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [super setViewControllers:[self getContainersByControllers:viewControllers] animated:animated];
}

- (UIViewController *)ppTopViewController {
    UIViewController *topController = [self topViewController];
    if ([topController isKindOfClass:[PPContainerViewController class]]) {
        topController = [(PPContainerViewController *)topController rootViewController];
    }
    return topController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        [viewController setDefaultBackItem];
    }
    [super pushViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *topController = [self ppTopViewController];
    BOOL shouldPopCallBack;
    if ([viewController isKindOfClass:[PPContainerViewController class]]) {
        shouldPopCallBack = topController != [(PPContainerViewController *)viewController rootViewController] ? YES : NO;
    } else {
        shouldPopCallBack = topController != viewController ? YES : NO;
    }
    if (topController.popCallback && shouldPopCallBack) {
        topController.popCallback();
    }
    return [super popToViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *topController = [self ppTopViewController];
    if (topController.popCallback) {
        topController.popCallback();
    }
    return [super popViewControllerAnimated:animated];
}

#pragma mark - UIAppearance

+ (void)setPpDefaultBackImageName:(NSString *)ppDefaultBackImageName {
//    [NSUserDefaults open:^(NSUserDefaults *user) {
//        [user setObject:ppDefaultBackImageName forKey:NSStringFromSelector(@selector(ppDefaultBackImageName))];
//    }];
}

+ (NSString *)ppDefaultBackImageName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromSelector(_cmd)];
}

+ (BOOL)ppNavigationStyleEnable {
    if (@available(iOS 11.0, *)) {
#if DEBUG
        return YES;
#else
        return YES;
#endif
    }
    return NO;
}

#pragma mark - life ciecle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageView];
    [self setupPageEvent];
}

- (void)setupPageView {
    self.view.backgroundColor = [UINavigationBar appearance].barTintColor;
    self.navigationBarHidden = [PPNavigationController ppNavigationStyleEnable];
}

- (void)setupPageEvent {
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    if ([self.popGestureDelegate respondsToSelector:action]) {
        self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
        self.popPanGesture.maximumNumberOfTouches = 1;
    } else {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    self.delegate = self;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    if (viewController.ppFullScreenPopGestureEnabled && self.fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
        self.popPanGesture.enabled = YES;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = NO;
        self.popPanGesture.enabled = NO;
        // self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];;
}

- (NSArray *)ppViewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (PPContainerViewController *containverVC in self.viewControllers) {
        if ([containverVC isKindOfClass:[PPContainerViewController class]]) {
            [viewControllers addObject:containverVC.rootViewController];
        } else {
            [viewControllers addObject:containverVC];
        }
    }
    return [viewControllers copy];
}

@end

/**
 * System Controller
 */

@implementation UIViewController(PPNavigationController)

- (void)setPpFullScreenPopGestureEnabled:(BOOL)ppFullScreenPopGestureEnabled {
    objc_setAssociatedObject(self, @selector(ppFullScreenPopGestureEnabled), @(ppFullScreenPopGestureEnabled), OBJC_ASSOCIATION_ASSIGN);
    @synchronized (self.ppNavigationController) {
        if (self.ppNavigationController) {
            self.ppNavigationController.popPanGesture.enabled = ppFullScreenPopGestureEnabled;
        }
    }
}

- (BOOL)ppFullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd)?:@(YES) boolValue];
}

- (void)setPpNavigationController:(PPNavigationController *)ppNavigationController {
    objc_setAssociatedObject(self, @selector(ppNavigationController), ppNavigationController, OBJC_ASSOCIATION_ASSIGN);
}

- (PPNavigationController *)ppNavigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPopCallback:(void (^)(void))popCallback {
    objc_setAssociatedObject(self, @selector(popCallback), popCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))popCallback {
    return objc_getAssociatedObject(self, _cmd);
}

- (id)copyWithZone:(NSZone *)zone {
    return [[self.class allocWithZone:zone] init];
}

/**
 * 设置默认返回按钮
 */
- (void)setDefaultBackItem {
    NSArray *images;
    NSArray *titles;
    NSString *backImageName = [PPNavigationController ppDefaultBackImageName];
    if (backImageName) {
        images = @[backImageName];
        titles = @[];
    } else {
        images = @[@"navigation_back"];
        titles = @[];
    }
    id target = self;
    SEL selector = @selector(leftBarItemClickAction:);
    if (![self respondsToSelector:selector]) {
        target = self;
        selector = @selector(didClickLeftItem:);
    }
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItem:target
//                                                            selector:selector
//                                                               space:5
//                                                              titles:titles
//                                                              images:images];
}

@end


@implementation UINavigationController (PPNavigationController)

- (id)copyWithZone:(NSZone *)zone {
    UINavigationController *containerNavi = [[self.class allocWithZone:zone] init];
    NSMutableArray<__kindof UIViewController *> *viewControllers = [NSMutableArray arrayWithCapacity:0];
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [viewControllers addObject:obj.copy];
    }];
    containerNavi.viewControllers = viewControllers;
    return containerNavi;
}

@end
