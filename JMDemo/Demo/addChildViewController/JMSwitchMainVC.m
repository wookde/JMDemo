//
//  JMSwitchMainVC.m
//  JMDemo
//
//  Created by liujiemin on 2026/1/11.
//

#import "JMSwitchMainVC.h"
#import "JMNormalExpenseVC.h"
#import "JMETCExpenseVC.h"

@interface JMSwitchMainVC ()

@property (nonatomic, strong) JMNormalExpenseVC *normalVC;
@property (nonatomic, strong) JMETCExpenseVC *etcVC;
@property (nonatomic, strong) UIButton *switchBtn;

@property (nonatomic, strong) UIViewController *currentVC;

@end

@implementation JMSwitchMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    // 默认展示普通报销
    [self displayChildVC:self.normalVC];
    
    // 初始化悬浮按钮（置于 View 层级最顶端）
    [self setupFloatingButton];
}

- (void)displayChildVC:(UIViewController *)childVC {
    if (!childVC) return;

    // 1. 建立父子关系
    [self addChildViewController:childVC];
    
    // 2. 添加视图（插入到 index 0 确保在 switchBtn 之下）
    [self.view insertSubview:childVC.view atIndex:0];
    
    // 3. 设置约束
    [childVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 4. 通知子控制器已完成移动
    [childVC didMoveToParentViewController:self];
    
    // 5. 更新引用
    self.currentVC = childVC;
}

- (void)setupFloatingButton {
    
    [self.view addSubview:self.switchBtn];
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
}

- (void)switchAction {
    UIViewController *fromVC = self.currentVC;
    UIViewController *toVC = (fromVC == self.normalVC) ? self.etcVC : self.normalVC;

    // 防止重复点击切换同一控制器
    if (fromVC == toVC) return;

    // --- 准备切换 ---
    
    // 1. 关键：将 toVC 添加为 child，但不要手动 addSubview (transitionInternal 会处理)
    [self addChildViewController:toVC];
    
    // 2. 准备动画前的状态通知
    [fromVC willMoveToParentViewController:nil];

    // 3. 执行切换动画
    [self transitionFromViewController:fromVC
                      toViewController:toVC
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
        [self.view bringSubviewToFront:self.switchBtn];
        // transitionFrom... 会自动处理 view 的 add/remove，这里通常处理约束
        [toVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    } completion:^(BOOL finished) {
        // 4. 完成后的清理工作
        [toVC didMoveToParentViewController:self];
        [fromVC removeFromParentViewController];
        
        // 5. 更新状态
        self.currentVC = toVC;
        [self updateButtonTitle];
    }];
}

- (void)updateButtonTitle {
    NSString *btnTitle = (self.currentVC == self.normalVC) ? @"切换到ETC" : @"切换到普通报销";
    [self.switchBtn setTitle:btnTitle forState:UIControlStateNormal];
}

#pragma mark - 懒加载
- (JMNormalExpenseVC *)normalVC {
    if (!_normalVC) {
        _normalVC = [[JMNormalExpenseVC alloc] init];
    }
    return _normalVC;
}

- (JMETCExpenseVC *)etcVC {
    if (!_etcVC) {
        _etcVC = [[JMETCExpenseVC alloc] init];
    }
    return _etcVC;
}

- (UIButton *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UIButton alloc] init];
        _switchBtn.backgroundColor = [UIColor grayColor];
        NSString *btnStitle = (self.currentVC == self.normalVC) ? @"ETC停车报销" : @"现场停车费报销";
        [_switchBtn setTitle:btnStitle forState:UIControlStateNormal];
        [_switchBtn addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchBtn;
}

@end
