//
//  NSObject+Runtime.m
//  safe
//
//  Created by chc on 2017/11/15.
//  Copyright © 2017年 com.chc. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)
+ (Class)getClassWithClassName:(NSString *)className
{
    return objc_getClass([className UTF8String]);
}

+ (void)exchangeMethod:(SEL)method withNewMethod:(SEL)newMethod forClass:(Class)class
{
    Method originalMethod = class_getInstanceMethod(class, method);
    Method swizzledMethod = class_getInstanceMethod(class, newMethod);
//    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    //先调用 class_addMethod,为了防止swizzle掉父类的方法导致后面的swizzle出现隐藏的bug（有可能子类A 替换到方法func:，然后子类B 又把func替换回来）
    BOOL didAddMethod =
    class_addMethod(class,
                    method,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            newMethod,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end

