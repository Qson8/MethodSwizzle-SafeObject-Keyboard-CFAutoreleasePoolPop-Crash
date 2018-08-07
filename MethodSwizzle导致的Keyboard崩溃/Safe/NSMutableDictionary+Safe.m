//
//  NSMutableDictionary+Safe.m
//  safe
//
//  Created by chc on 2017/11/15.
//  Copyright © 2017年 com.chc. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import "NSObject+Runtime.h"

@implementation NSMutableDictionary (Safe)
+ (void)load {
    Class class = [self getClassWithClassName:@"__NSDictionaryM"];
    
    [self exchangeMethod:@selector(setObject:forKeyedSubscript:) withNewMethod:@selector(sf_setObject:forKeyedSubscript:) forClass:class];
    
    [self exchangeMethod:@selector(setObject:forKey:) withNewMethod:@selector(sf_setObject:forKey:) forClass:class];
}

/** dictM[nil] = nil */
- (void)sf_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (!key || !self || !obj) {
        return;
    }
    [self sf_setObject:obj forKeyedSubscript:key];
}

/** [dictM setObject:nil forKey:nil] */
- (void)sf_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey || !anObject || !self) {
        return;
    }
    [self sf_setObject:anObject forKey:aKey];
}

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

