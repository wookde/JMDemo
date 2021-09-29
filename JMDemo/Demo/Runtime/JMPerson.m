//
//  JMPerson.m
//  JMDemo
//
//  Created by liujiemin on 2021/9/23.
//

#import "JMPerson.h"
#import "JMStudent.h"

@implementation JMPerson

+ (void)load {
    NSLog(@"JMPerson load");
    [JMStudent class];
    [JMPerson class];
}

+ (void)initialize {
    NSLog(@"Person initialize");
}

@end
