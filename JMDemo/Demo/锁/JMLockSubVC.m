//
//  JMLockSubVC.m
//  JMDemo
//
//  Created by liujiemin on 2021/11/3.
//

#import "JMLockSubVC.h"

@interface JMLockSubVC ()

@property (nonatomic, strong) NSMutableArray *arry;

@end

@implementation JMLockSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arry = [NSMutableArray array];
    
    [self.arry addObject:@3];
}


@end
