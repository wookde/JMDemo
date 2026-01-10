//
//  JMTouchEventsVC.m
//  JMDemo
//
//  Created by liujiemin on 2026/1/7.
//

#import "JMTouchEventsVC.h"

@interface JMView1 : UIView

@end

@implementation JMView1

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"进入 [%@] hitTest:", self.accessibilityLabel);
    UIView *result = [super hitTest:point withEvent:event];
    NSLog(@"离开 [%@] hitTest:，结果是: %@", self.accessibilityLabel, result.accessibilityLabel);
    return result;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"检查 [%@] pointInside:", self.accessibilityLabel);
    BOOL isInside = [super pointInside:point withEvent:event];
    NSLog(@"[%@] pointInside 结果: %@", self.accessibilityLabel, isInside ? @"YES" : @"NO");
    return isInside;
}

@end

@interface JMView2 : UIView

@end

@implementation JMView2

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"进入 [%@] hitTest:", self.accessibilityLabel);
    UIView *result = [super hitTest:point withEvent:event];
    NSLog(@"离开 [%@] hitTest:，结果是: %@", self.accessibilityLabel, result.accessibilityLabel);
    return result;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"检查 [%@] pointInside:", self.accessibilityLabel);
    BOOL isInside = [super pointInside:point withEvent:event];
    NSLog(@"[%@] pointInside 结果: %@", self.accessibilityLabel, isInside ? @"YES" : @"NO");
    return isInside;
}

@end

@interface JMTouchEventsVC ()

@property (nonatomic, strong) JMView1 *view1;

@property (nonatomic, strong) JMView2 *view2;

@end

@implementation JMTouchEventsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    self.title = @"点击事件的传递";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.view1];
    [self.view1 addSubview:self.view2];
    
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.center.equalTo(self.view);
    }];
    
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.equalTo(self.view);
    }];
}

#pragma mark - 懒加载
- (JMView1 *)view1 {
    if (!_view1) {
        _view1 = [[JMView1 alloc] init];
        _view1.accessibilityLabel = @"view1";
        _view1.backgroundColor = [UIColor orangeColor];
    }
    return _view1;
}

- (JMView2 *)view2 {
    if (!_view2) {
        _view2 = [[JMView2 alloc] init];
        _view2.alpha = 0;
        _view2.accessibilityLabel = @"view2";
        _view2.backgroundColor = [UIColor cyanColor];
    }
    return _view2;
}

@end
