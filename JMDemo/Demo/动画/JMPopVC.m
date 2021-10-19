//
//  JMPopVC.m
//  JMDemo
//
//  Created by wookde on 2021/8/4.
//

#import "JMPopVC.h"
#import "UIView+KGAnimation.h"
#import <pop/POP.h>

@interface JMPopVC ()

// label
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *demoView;
@property (nonatomic, assign) BOOL animated;

@end

@implementation JMPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"Pop";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:25];
    self.label = label;
    label.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:self.label];
//
//    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.centerY.equalTo(self.view);
//        make.width.mas_equalTo(150);
//        make.height.mas_equalTo(30);
//    }];
    
    UIView *demoView = [[UIView alloc] init];
    self.demoView = demoView;
    demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:demoView];
    [self.demoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(KGNaviBarH + 100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(90);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 移动
//    POPBasicAnimation *baseAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
//    baseAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
//        NSLog(@"动画完成");
//    };
//    baseAnim.clampMode = kPOPAnimationClampBoth;
//    baseAnim.duration = 1.0;
//    baseAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    baseAnim.fromValue = @(self.demoView.center);
//    baseAnim.toValue = @(self.view.center);
//    [self.demoView pop_addAnimation:baseAnim forKey:@"baseAnim"];
    
    // 倒计时
//    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
//        prop.writeBlock = ^(id obj, const CGFloat *values) {
//            NSLog(@"%d", (int)values[0]);
//            int value = (int)values[0];
//            NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d", value/60, value%60,(int)(values[0]*100)%100];
//            self.label.text = timeStr;
//        };
//    }];
//
//    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
//    anBasic.property = prop;    //自定义属性
//    anBasic.fromValue = @(1*60);   //从0开始
//    anBasic.toValue = @(0);  //180秒
//    anBasic.duration = 3*60;    //持续3分钟
//    anBasic.beginTime = CACurrentMediaTime();    //延迟1秒开始
//    [self.label pop_addAnimation:anBasic forKey:@"countdown"];
    
    // spring移动
//    POPSpringAnimation *anSpr = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//    anSpr.completionBlock = ^(POPAnimation *anim, BOOL finished) {
//        NSLog(@"动画完成");
//    };
//    anSpr.springBounciness = 20.0;
//    anSpr.fromValue = @(self.demoView.center);
//    anSpr.toValue = @(self.view.center);
//    [self.demoView pop_addAnimation:anSpr forKey:@"anSpr"];
    [self jumpAnimation];
}

- (void)jumpAnimation {
    
    [self.demoView.layer pop_removeAllAnimations];
    POPDecayAnimation *anRotaion=[POPDecayAnimation animation];
    anRotaion.property = [POPAnimatableProperty propertyWithName:kPOPLayerRotation];
    anRotaion.beginTime = CACurrentMediaTime() + 0.0;
    
    if (self.animated) {
        anRotaion.velocity = @(-150);
    }else{
        anRotaion.velocity = @(150);
        anRotaion.fromValue =  @(25.0);
    }
    
    self.animated = !self.animated;
    
    anRotaion.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [self jumpAnimation];
        }
    };
    
    [self.demoView.layer pop_addAnimation:anRotaion forKey:@"myRotationView"];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
