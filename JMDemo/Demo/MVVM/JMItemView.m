//
//  JMItemView.m
//  JMDemo
//
//  Created by liujiemin on 2025/10/26.
//

#import "JMItemView.h"
#import "JMItemViewModel.h"

static void *ItemTitleContext = &ItemTitleContext;
static void *ItemQuantityContext = &ItemQuantityContext;

@interface JMItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *quantityLabel;
@property (nonatomic, strong) JMItemViewModel *viewModel; // 持有ViewModel

@end

@implementation JMItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupSubviews];
    }
    return self;
}

- (void)_setupSubviews {
    self.backgroundColor = [UIColor lightGrayColor];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    _quantityLabel = [[UILabel alloc] init];
    _quantityLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_quantityLabel];
    
    // 使用AutoLayout或Frame布局（此处为示例，使用Frame简写）
    _titleLabel.frame = CGRectMake(10, 10, 200, 30);
    _quantityLabel.frame = CGRectMake(10, 50, 200, 30);
}

- (void)bindViewModel:(JMItemViewModel *)viewModel {
    // 先移除旧的观察（如果存在）
    [self unbindViewModel];
    
    self.viewModel = viewModel;
    
    [self updateUIWithModel:viewModel.model];
    
    // 使用KVO监听ViewModel中model
    [self.viewModel addObserver:self forKeyPath:@"model" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)unbindViewModel {
    if (self.viewModel) {
        @try {
            // 安全移除观察者
            [self.viewModel removeObserver:self forKeyPath:@"model" context:nil];
        } @catch (NSException *exception) {
            NSLog(@"移除KVO观察者时出现异常: %@", exception);
        }
        self.viewModel = nil;
    }
}

// KVO回调方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"model"]) {
        JMItemModel *newModel = change[NSKeyValueChangeNewKey];
        if (newModel && [newModel isKindOfClass:[JMItemModel class]]) {
            [self updateUIWithModel:newModel];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateUIWithModel:(JMItemModel *)model {
    self.titleLabel.text = [self _formatTitle:model.title];
    self.quantityLabel.text = [self _formatQuantity:model.quantity];
}

// MARK: - Private Helpers
- (NSString *)_formatTitle:(NSString *)originalTitle {
    return [NSString stringWithFormat:@"品名：%@", originalTitle];
}

- (NSString *)_formatQuantity:(NSInteger)quantity {
    return [NSString stringWithFormat:@"库存：%ld件", (long)quantity];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self unbindViewModel]; // 在View销毁时务必移除观察者
}

@end
