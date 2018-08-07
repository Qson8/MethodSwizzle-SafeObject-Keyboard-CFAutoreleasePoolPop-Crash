//
//  NSNull+Safe.m
//  safe
//
//  Created by chc on 2017/11/15.
//  Copyright © 2017年 com.chc. All rights reserved.
//

#import "NSNull+Safe.h"

@implementation NSNull (Safe)
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature *signature = [super methodSignatureForSelector:sel];
    if (!signature) {
        signature = [NSMethodSignature signatureWithObjCTypes:@encode(void)];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
}
@end
