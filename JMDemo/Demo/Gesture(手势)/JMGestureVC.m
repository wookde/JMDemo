//
//  JMGestureVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/11/9.
//

#import "JMGestureVC.h"

@interface JMGestureVC ()

@end

@implementation JMGestureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"手势冲突";
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 200, 200)];
    view.backgroundColor = [UIColor grayColor];
    UITapGestureRecognizer *gap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gapAction)];
    [view addGestureRecognizer:gap];
    [self.view addSubview:view];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 60, 60);
    [btn setTitle:@"btn" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor yellowColor];
    [view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *subView= [[UIView alloc] init];
    subView.frame = CGRectMake(0, 80, 60, 60);
    subView.backgroundColor = [UIColor greenColor];
    [view addSubview:subView];
}

- (void)gapAction {
    NSLog(@"手势触发了");
}

- (void)btnAction {
    NSLog(@"按钮点击事件");
}

@end
