//
//  JMIntegralLabelVC.m
//  JMDemo
//
//  Created by liujiemin on 2026/1/6.
//

#import "JMIntegralLabelVC.h"
#import "YSXIntegralLabel.h"

@interface JMIntegralLabelVC ()

@property (nonatomic, strong) YSXIntegralLabel *integralLab;

@end

@implementation JMIntegralLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.integralLab];
    
    [self.integralLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(200);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    int randomNum = arc4random() % 10000 + 1;
    NSString *result = [NSString stringWithFormat:@"%d", randomNum];
    [self.integralLab changeToStr:result animated:YES];
}

- (YSXIntegralLabel *)integralLab {
    if (!_integralLab) {
        _integralLab = [[YSXIntegralLabel alloc] initWithNumber:@"100" textColor:[UIColor orangeColor] font:[UIFont systemFontOfSize:82] animated:YES];
    }
    return _integralLab;
}

@end
