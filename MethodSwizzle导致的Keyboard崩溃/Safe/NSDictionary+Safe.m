//
//  NSDictionary+Safe.m
//  safe
//
//  Created by chc on 2017/11/15.
//  Copyright © 2017年 com.chc. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+Runtime.h"

@implementation NSDictionary (Safe)
+ (void)load {
    Class class = [self getClassWithClassName:@"__NSPlaceholderDictionary"];
    
    [self exchangeMethod:@selector(initWithObjects:forKeys:count:) withNewMethod:@selector(sf_initWithObjects:forKeys:count:) forClass:class];
}

/** @{@"aa": nil, @"bb": @"bb", nil : @"cc"} */
- (instancetype)sf_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt
{
    id nObjects[cnt];
    id nKeys[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i] && keys[i]) {
            nObjects[j] = objects[i];
            nKeys[j] = keys[i];
            j++;
        }
    }
    
    return [self sf_initWithObjects:nObjects forKeys:nKeys count:j];
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
