//
//  JMTextViewVC.m
//  JMDemo
//
//  Created by liujiemin on 2025/3/14.
//

#import "JMTextViewVC.h"
#import "JMTextView.h"

@interface JMTextViewVC ()<UITextViewDelegate>

@property (nonatomic, strong) JMTextView *displayTextView;
@property (nonatomic, strong) UITextView *inputTextView;

@end

@implementation JMTextViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
}

- (void)initSubViews {
    self.title = @"TextView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 使用自定义的 displayTextView
    self.displayTextView = [[JMTextView alloc] initWithFrame:CGRectMake(20, 100, 300, 80)];
    self.displayTextView.text = @"你叫什么名字";
    self.displayTextView.editable = NO;
    self.displayTextView.selectable = YES;  // 允许选择文字
    [self.view addSubview:self.displayTextView];
    
    // 输入框
    self.inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 200, 300, 80)];
    self.inputTextView.layer.borderWidth = 1;
    self.inputTextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.inputTextView.delegate = self;
    [self.view addSubview:self.inputTextView];
    
    // 确保键盘不会被隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillShow:(NSNotification *)notification {
    if (![self.inputTextView isFirstResponder]) {
        [self.inputTextView becomeFirstResponder];  // 强制显示键盘
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    // 监听键盘隐藏，不做任何操作，确保键盘不会因菜单显示而被隐藏
    if (![self.inputTextView isFirstResponder]) {
        [self.inputTextView becomeFirstResponder];  // 强制显示键盘
    }
}

// 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
