//
//  UIViewController+AutorotationSupport.m
//  MobMathApp
//
//  Created by Hasayakey on 2020/6/8.
//  Copyright © 2020 河小象. All rights reserved.
//

#import "UIViewController+AutorotationSupport.h"
#import "NSObject+Swizzle.h"

BOOL isUserInterfaceIdiomPhone(void) {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

@implementation UIViewController (AutorotationSupport)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self hx_swizzleInstanceMethodWithClass:[self class]
                                   fromSelector:@selector(shouldAutorotate)
                                     toSelector:@selector(_shouldAutorotate)];
        [self hx_swizzleInstanceMethodWithClass:[self class]
                                   fromSelector:@selector(supportedInterfaceOrientations)
                                     toSelector:@selector(_supportedInterfaceOrientations)];
        [self hx_swizzleInstanceMethodWithClass:[self class]
                                   fromSelector:@selector(preferredInterfaceOrientationForPresentation)
                                     toSelector:@selector(_preferredInterfaceOrientationForPresentation)];
    });
}

- (BOOL)_shouldAutorotate {
    return isUserInterfaceIdiomPhone() ? NO: YES;
}

- (UIInterfaceOrientationMask)_supportedInterfaceOrientations {
    return isUserInterfaceIdiomPhone() ? UIInterfaceOrientationMaskPortrait: UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)_preferredInterfaceOrientationForPresentation {
    return isUserInterfaceIdiomPhone() ? UIInterfaceOrientationPortrait: UIInterfaceOrientationPortrait;
}

@end
