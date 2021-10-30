//
//  JMLockVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/29.
//

#import "JMLockVC.h"
#import <libkern/OSAtomic.h>

@interface JMLockVC ()

@end

@implementation JMLockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSThread exit];
}

@end
