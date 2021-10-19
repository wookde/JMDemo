//
//  JMCALayerVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/19.
//

#import "JMCALayerVC.h"
#import "JMView.h"

@interface JMCALayerVC ()

@property (nonatomic, strong) JMView *jmView;

@property (nonatomic, strong) CALayer *colorLayer;

@property (nonatomic, strong) UIView *carView;

@end

@implementation JMCALayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"CALayer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // UIView
    self.jmView = [[JMView alloc] init];
    self.jmView.frame = CGRectMake(30, KGNaviBarH + 30, KGScreenW - 60, 60);
    self.jmView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.jmView];
    
    // CALayer
    self.colorLayer = [[CALayer alloc] init];
    self.colorLayer.frame = CGRectMake(30, KGNaviBarH + 100, KGScreenW - 60, 60);
    self.colorLayer.backgroundColor = [UIColor darkGrayColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    self.carView = [[UIView alloc] init];
    self.carView.frame = CGRectMake(0, 0, 50, 50);
    self.carView.center = CGPointMake(30, KGNaviBarH + 260);
    self.carView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.carView];
}

/*
 隐式动画
 1、当我们改变一个CALayer属性时，Core Animation是如何判断动画类型和持续时间呢？实际上动画执行的时间取决于当前事务的设置，动画类型则取决于图层行为。
 2、事务，其实是Core Animation用来包含一系列属性动画集合的机制，通过指定事务来改变图层的可动画属性，这些变化都不是立刻发生变化的，
 而是在事务被提交的时候才启动一个动画过渡到新值。任何可以做动画的图层属性都会被添加到栈顶的事务。
 3、事务是通过CATransaction类来做管理，它没有属性或者实例方法，而且也不能通过alloc和init去创建它
 4、现在再来考虑隐式动画，其实是Core Animation在每个RunLoop周期中会自动开始一次新的事务，即使你不显式的使用[CATranscation begin]开始一次事务，任何在一次RunLoop运行时循环中属性的改变都会被集中起来，执行默认0.25秒的动画。
 5、更多详情:https://www.jianshu.com/p/ea660c2ca2e9
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    
    self.jmView.backgroundColor = randomColor;
    
    // 自定义动画对象
//    CATransition *transition = [CATransition animation];
//    transition.duration = 2.0;
//    transition.type = kCATransitionReveal;
//    transition.subtype = kCATransitionFromLeft;
//    self.colorLayer.actions = @{@"backgroundColor":transition};
//    self.colorLayer.backgroundColor = randomColor.CGColor;
    
    // 控制隐式动画的参数
    // 入栈
    [CATransaction begin];
    //1.设置动画执行时间
    [CATransaction setAnimationDuration:1];
    //2.设置动画执行完毕后的操作：颜色渐变之后再旋转90度
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform  = CGAffineTransformRotate(transform, M_PI);
        self.colorLayer.affineTransform = transform;
    }];
    self.colorLayer.backgroundColor = randomColor.CGColor;
    //出栈
    [CATransaction commit];
    
    // 按照轨迹移动
    [self moveOnBezierPath];
}

- (void)moveOnBezierPath {
    // 按照轨迹移动
    UIBezierPath *bezierPath  = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(30, KGNaviBarH + 260)];
    [bezierPath addCurveToPoint:CGPointMake(KGScreenW - 30, KGNaviBarH + 260) controlPoint1:CGPointMake(150, KGNaviBarH + 260) controlPoint2:CGPointMake(KGScreenW - 150, 260)];
    
    //2.绘制飞行路线
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    //4.设置关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 5.0;
    animation.path = bezierPath.CGPath;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.rotationMode = kCAAnimationRotateAuto; //设置根据曲线的切线自动旋转,让动画更加真实
    [self.carView.layer addAnimation:animation forKey:nil];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
