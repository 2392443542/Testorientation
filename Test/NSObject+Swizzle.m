//
//  NSObject+Swizzle.m
//  MobMathApp
//
//  Created by Hasayakey on 2020/6/15.
//  Copyright © 2020 河小象. All rights reserved.
//

#import "NSObject+Swizzle.h"

@implementation NSObject (Swizzle)

+ (void)hx_swizzleInstanceMethodWithClass:(Class)class fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    Method fromMethod = class_getInstanceMethod(class, fromSelector);
    Method toMethod = class_getInstanceMethod(class, toSelector);
    
    if (class_addMethod(class, fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        class_replaceMethod(class, toSelector, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
    } else {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

+ (void)hx_swizzleClassMethodWithClass:(Class)class fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    Method fromMethod = class_getClassMethod(class, fromSelector);
    Method toMethod = class_getClassMethod(class, toSelector);
    class = object_getClass((id)class);
    
    if (class_addMethod(class, fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        class_replaceMethod(class, toSelector, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
    } else {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

@end
