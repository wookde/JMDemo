//
//  JMStudent.m
//  JMDemo
//
//  Created by liujiemin on 2021/9/23.
//

#import "JMStudent.h"

@implementation JMStudent

+ (void)load {
    NSLog(@"JMStudent load");
}

+ (void)initialize {
    NSLog(@"JMStudent initialize");
}


+ (void)action {
    [self eat];
    [JMStudent eat];
}

+ (void)eat {
    NSLog(@"Student Eat");
}

@end
