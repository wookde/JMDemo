//
//  JMMVVMVC.m
//  JMDemo
//
//  Created by liujiemin on 2025/10/26.
//

#import "JMMVVMVC.h"
#import "JMItemModel.h"
#import "JMItemViewModel.h"
#import "JMItemView.h"

@interface JMMVVMVC ()

// viewModel
@property (nonatomic, strong) JMItemViewModel *viewModel;
// itemView
@property (nonatomic, strong) JMItemView *itemView;

@end

@implementation JMMVVMVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1. 创建Model
    JMItemModel *model = [[JMItemModel alloc] init];
    model.itemId = @"123";
    model.title = @"示例商品";
    model.quantity = 10;
    
    // 2. 创建ViewModel
    self.viewModel = [[JMItemViewModel alloc] initWithModel:model];
    
    // 3. 创建自定义View并绑定ViewModel
    self.itemView = [[JMItemView alloc] initWithFrame:CGRectMake(50, 100, 220, 100)];
    [self.itemView bindViewModel:self.viewModel]; // 建立绑定关系
    
    // 4. 添加到视图层级
    [self.view addSubview:self.itemView];
    
    // 5. （可选）模拟数据更新
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        model.quantity = 25;
        [self.viewModel updateModel:model]; // 3秒后，数量会变为25，界面会自动更新
    });
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
