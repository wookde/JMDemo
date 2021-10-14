//
//  JMDelegateVC.m
//  JMDemo
//
//  Created by wookde on 2021/10/8.
//

#import "JMDelegateVC.h"
#import "JMDelegateObject.h"
#import "JMObjectA.h"
#import "JMObjectB.h"


@interface JMDelegateVC ()

@property (nonatomic, strong) NSMutableArray *datas;

@end

// 使用代理模式,实现一对多
@implementation JMDelegateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"Delegate";
    self.view.backgroundColor = [UIColor whiteColor];
    
    JMDelegateObject *obj = [[JMDelegateObject alloc] init];
    [obj addDeleagte:[[JMObjectA alloc] init]];
    [obj addDeleagte:[[JMObjectB alloc] init]];
    
    [obj action];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
