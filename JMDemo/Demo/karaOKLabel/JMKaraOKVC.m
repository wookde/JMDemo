//
//  JMKaraOKVC.m
//  JMDemo
//
//  Created by liujiemin on 2025/11/14.
//

#import "JMKaraOKVC.h"
#import "FOSKaraOKLabel.h"

@interface JMKaraOKVC ()

@property(nonatomic, strong) FOSKaraOKLabel *digitLabel;

@end

@implementation JMKaraOKVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.digitLabel.frame = CGRectMake(0, 200, self.view.frame.size.width, 40);
    
    
    [self.view addSubview:self.digitLabel];
    self.digitLabel.text = @"12345678";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.digitLabel startAnimating];
}

- (FOSKaraOKLabel *)digitLabel {
    if (!_digitLabel) {
        _digitLabel = [[FOSKaraOKLabel alloc] init];
        _digitLabel.textColor = [UIColor redColor];
        _digitLabel.font = [UIFont fontWithName:@"PingFang SC" size:36];
        _digitLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _digitLabel;
}


@end
