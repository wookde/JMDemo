//
//  JMObjectB.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/8.
//

#import "JMObjectB.h"
#import "JMDelegateObject.h"

@interface JMObjectB() <JMDeleagte>

@end

@implementation JMObjectB

- (void)doSomthing {
    NSLog(@"%s",__func__);
}

@end
