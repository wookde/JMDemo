//
//  JMNSCodingVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/10/27.
//

#import "JMNSCodingVC.h"
#import "JMNSCodingModel.h"

@interface JMNSCodingVC ()

@end

@implementation JMNSCodingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)prepareUI {
    self.title = @"NSCoding";
    self.view.backgroundColor = [UIColor whiteColor];
    
    JMNSCodingModel *model = [[JMNSCodingModel alloc] init];
    model.name = @"wookde";
    model.age = @"18";
    [JMNSCodingModel saveModel:model];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JMNSCodingModel *model = [JMNSCodingModel getModel];
    NSLog(@"name:%@/nage:%@",model.name,model.age);
}


@end
