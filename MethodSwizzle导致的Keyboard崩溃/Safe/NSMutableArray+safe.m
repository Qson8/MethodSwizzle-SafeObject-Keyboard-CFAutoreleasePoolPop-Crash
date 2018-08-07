//
//  NSMutableArray+safe.m
//  safe
//
//  Created by chc on 2017/11/15.
//  Copyright © 2017年 com.chc. All rights reserved.
//

#import "NSMutableArray+safe.h"
#import "NSObject+Runtime.h"

@implementation NSMutableArray (safe)
+ (void)load {
    Class class = [self getClassWithClassName:@"__NSArrayM"];
    
    [self exchangeMethod:@selector(addObject:) withNewMethod:@selector(sf_addObject:) forClass:class];
    
    [self exchangeMethod:@selector(insertObject:atIndex:) withNewMethod:@selector(sf_insertObject:atIndex:) forClass:class];
    
    // arrayM[max] = @"1"
    [self exchangeMethod:@selector(setObject:atIndexedSubscript:) withNewMethod:@selector(sf_setObject:atIndexedSubscript:) forClass:class];
}

- (void)sf_addObject:(id)anObject
{
    if (!anObject) {
        return;
    }
    [self sf_addObject:anObject];
}

- (void)sf_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject || index > self.count)
        return;
    [self sf_insertObject:anObject atIndex:index];
}

/** arrayM[max] = @"1" */
- (void)sf_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index {
    if (!anObject || index > self.count)
        return;
    [self sf_setObject:anObject atIndexedSubscript:index];
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
