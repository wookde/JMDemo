//
//  JMFrameAndBoundsVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/18.
//

#import "JMFrameAndBoundsVC.h"
#import "JMView.h"
#import "JMButton.h"

@interface JMFrameAndBoundsVC ()

@property (nonatomic, strong) JMView *bgView;

@property (nonatomic, strong) UIButton *btn;

@end

@implementation JMFrameAndBoundsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"Frame/Bounds";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat statusH = [UIApplication sharedApplication].statusBarFrame.size.height;
    JMView *view = [[JMView alloc] initWithFrame:CGRectMake(10, statusH + 44 + 10, 200, 200)];
    self.bgView = view;
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    self.btn = btn;
    btn.backgroundColor = [UIColor grayColor];
    [view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction {
    CGPoint rect = [self.btn convertPoint:CGPointZero toView:self.bgView];
    //position属性发生动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    //动画要去的点
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    //时间
    animation.duration = 2.0;
    [self.btn.layer addAnimation:animation forKey:@"weiyi"];
    
    // 等动画结束后，改变按钮真正位置
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btn.center = CGPointMake(100, 100);
    });
    
    NSLog(@"btnAction");
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
