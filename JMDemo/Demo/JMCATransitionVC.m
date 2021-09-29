//
//  JMCATransitionVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/7/21.
//

#import "JMCATransitionVC.h"

@interface JMCATransitionVC ()


@property (nonatomic, strong) UIView *view1;

@property (nonatomic, strong) UIView *view2;

@property (nonatomic, strong) UIImageView *currentImageView;

@property (nonatomic, strong) UIImageView *imageView1;

@property (nonatomic, strong) UIImageView *imageView2;

// 动画是否完成
@property (nonatomic, assign) BOOL isAnimating;


@end

@implementation JMCATransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"动画转场";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view1 = [[UIView alloc] init];
    self.view1 = view1;
    view1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *view2 = [[UIView alloc] init];
    self.view2 = view2;
    view2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.view1);
    }];
    
    
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    self.currentImageView = imageView1;
    imageView1.image = [UIImage imageNamed:@"Image1"];
    [self.view addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    self.imageView2 = imageView2;
    imageView2.image = [UIImage imageNamed:@"Image1"];
    [self.view addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right);
        make.top.width.height.equalTo(self.view);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    self.imageView.image = [UIImage imageNamed:@"Image2"];
//    /** 转场动画代码 */
//    // 创建转场动画对象
//    CATransition *anim = [CATransition animation];
//
//    // 设置转场类型
//    anim.type = @"push";
//
//    // 设置动画的方向
//    anim.subtype = kCATransitionFromRight;
//
//    anim.duration = 0.5;
//
//    [self.imageView.layer addAnimation:anim forKey:nil];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        [self.view2 mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view1.mas_left);
//        }];
//        [self.view layoutIfNeeded];
//    }];
    
    if (self.isAnimating) {
        return;
    }
    self.isAnimating = YES;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [weakSelf.imageView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [weakSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [weakSelf.currentImageView removeFromSuperview];
        weakSelf.currentImageView = nil;
        weakSelf.currentImageView = weakSelf.imageView2;
        [weakSelf createImageView];
        weakSelf.isAnimating = NO;
    }];
}

- (void)createImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView2 = imageView;
    imageView.image = [UIImage imageNamed:@"Image1"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right);
        make.top.width.height.equalTo(self.view);
    }];
}

- (UIColor*)randomColor {
    NSInteger aRed = arc4random() %255;
    NSInteger aGreen = arc4random() %255;
    NSInteger aBlue = arc4random() %255;
    UIColor *randColor = [UIColor colorWithRed:aRed/255.0f green:aGreen/255.0f blue:aBlue/255.0f alpha:1.0f];
    return randColor;
}

- (void)dealloc {
    NSLog(@"页面被销毁");
}

@end
