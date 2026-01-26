//
//  JMETCExpenseVC.m
//  JMDemo
//
//  Created by liujiemin on 2026/1/11.
//

#import "JMETCExpenseVC.h"

@interface JMETCExpenseVC ()

@end

@implementation JMETCExpenseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    self.title = @"ETC报销";
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
