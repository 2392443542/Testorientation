//
//  NSObject+Swizzle.h
//  MobMathApp
//
//  Created by Hasayakey on 2020/6/15.
//  Copyright © 2020 河小象. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzle)

+ (void)hx_swizzleInstanceMethodWithClass:(Class)class fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector;
+ (void)hx_swizzleClassMethodWithClass:(Class)classObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector;

@end

NS_ASSUME_NONNULL_END
