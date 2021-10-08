//
//  JMObjectA.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/8.
//

#import "JMObjectA.h"
#import "JMDelegateObject.h"

@interface JMObjectA() <JMDeleagte>

@end

@implementation JMObjectA

- (void)doSomthing {
    NSLog(@"%s",__func__);
}

@end
