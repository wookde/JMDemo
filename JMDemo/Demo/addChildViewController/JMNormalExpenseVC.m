//
//  JMNormalExpenseVC.m
//  JMDemo
//
//  Created by liujiemin on 2026/1/11.
//

#import "JMNormalExpenseVC.h"

@interface JMNormalExpenseVC ()

@end

@implementation JMNormalExpenseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    self.title = @"普通报销";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
