//
//  NSArray+safe.m
//  safe
//
//  Created by chc on 2017/11/15.
//  Copyright © 2017年 com.chc. All rights reserved.
//

#import "NSArray+safe.h"
#import "NSObject+Runtime.h"

@implementation NSArray (safe)
+ (void)load {
    
    // id obj = array[i];
    Class class = [self getClassWithClassName:@"__NSArrayI"];
    [self exchangeMethod:@selector(objectAtIndex:) withNewMethod:@selector(sf_objectAtIndex:) forClass:class];
    [self exchangeMethod:@selector(objectAtIndexedSubscript:) withNewMethod:@selector(sf_objectAtIndexedSubscript:) forClass:class];
    
    // @[@"1", nil]
    class = [self getClassWithClassName:@"__NSPlaceholderArray"];
    [self exchangeMethod:@selector(initWithObjects:count:) withNewMethod:@selector(sf_initWithObjects:count:) forClass:class];
    
    // array 为空时 id obj = array[i];
    class = [self getClassWithClassName:@"__NSArray0"];
    [self exchangeMethod:@selector(objectAtIndex:) withNewMethod:@selector(sf0_objectAtIndex:) forClass:class];
    [self exchangeMethod:@selector(objectAtIndexedSubscript:) withNewMethod:@selector(sf0_objectAtIndexedSubscript:) forClass:class];
    
    // arrayM 为空时 id obj = arrayM[i];
    class = [self getClassWithClassName:@"__NSArrayM"];
    [self exchangeMethod:@selector(objectAtIndex:) withNewMethod:@selector(sfM0_objectAtIndex:) forClass:class];
    [self exchangeMethod:@selector(objectAtIndexedSubscript:) withNewMethod:@selector(sfM0_objectAtIndexedSubscript:) forClass:class];
}

/** @[@"1", nil] */
- (instancetype)sf_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt
{
    id nObjects[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i]) {
            nObjects[j] = objects[i];
            j++;
        }
    }
    
    return [self sf_initWithObjects:nObjects count:j];
}

- (id)sf_objectAtIndex:(NSUInteger)index
{
    @autoreleasepool {
        if (index >= self.count) {
            return nil;
        }
        return [self sf_objectAtIndex:index];
    }
}

/** NSString *str1 = array[2] */
- (id)sf_objectAtIndexedSubscript:(NSUInteger)index
{
    @autoreleasepool {
        if (index >= self.count) {
            return nil;
        }
        return [self sf_objectAtIndexedSubscript:index];
    }
}

- (id)sf0_objectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self sf0_objectAtIndex:index];
}

- (id)sf0_objectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self sf0_objectAtIndexedSubscript:index];
}

- (id)sfM0_objectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self sfM0_objectAtIndex:index];
}

- (id)sfM0_objectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self sfM0_objectAtIndexedSubscript:index];
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
